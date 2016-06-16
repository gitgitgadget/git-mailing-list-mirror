From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2016, #06; Tue, 17)
Date: Tue, 17 May 2016 15:47:28 -0700
Message-ID: <xmqqwpmsti7z.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 00:47:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2nm8-0007f2-BV
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 00:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbcEQWrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 18:47:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752115AbcEQWrc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 18:47:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 04D671BD1B;
	Tue, 17 May 2016 18:47:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	v2sGWn1BS7WXBUE01aXJ1GPf8c=; b=ZjxSEJr36kZsv+Je6+lPkNRtGx0UR+v8N
	nEPy/tqKLzeve20ygSc386BE4Wcy8nHnLpdij5mWkpheqPyzPwAjC4fwtLi8QYnW
	rZtA2FYX7mQH0GUO4oCU33TW/TTI2cBawZtzmaK9nd4n0OOiHlL4SToTWZLIjGk/
	aLAH4pdu4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=sW9
	Hg/i/TPuBrVtqJWn5pL/ahEWFkTNIFKQ6aVQ8TcWYwcS5IaVTuZ3o6xf/f3pp7GH
	+hroZhM1BZxnE8qIhIQ5xLlWkuMJra6D17Vhz5io3P0Mbx7oEavWaO33poVlGZsY
	aExw3Ze9aqjOSxNCMIpBsBRMZxl4pwAVSRTL5urE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC2AC1BD1A;
	Tue, 17 May 2016 18:47:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 173A31BD19;
	Tue, 17 May 2016 18:47:30 -0400 (EDT)
X-master-at: 1f66975deb8402131fbf7c14330d0c7cdebaeaa2
X-next-at: 927f4258f48da33cf64d9a9f47fd3a0ac725a748
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5607F0EA-1C81-11E6-A072-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294920>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The 'master' branch now has 390 non-merge commits in this cycle.  On
the 'maint' front, 2.8.2 is out and fixes that have been in 'master'
accumulates on it for 2.8.3, which probably should be tagged sometime
late this week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/hooks (2016-05-04) 4 commits
  (merged to 'next' on 2016-05-09 at 23cf808)
 + hooks: allow customizing where the hook directory is
 + githooks.txt: minor improvements to the grammar & phrasing
 + githooks.txt: amend dangerous advice about 'update' hook ACL
 + githooks.txt: improve the intro section

 A new configuration variable core.hooksPath allows customizing
 where the hook directory is.


* ak/t4151-ls-files-could-be-empty (2016-05-09) 1 commit
  (merged to 'next' on 2016-05-10 at 36ae38c)
 + t4151: make sure argument to 'test -z' is given

 Test fix.


* bn/config-doc-tt-varnames (2016-05-05) 1 commit
  (merged to 'next' on 2016-05-10 at aa7b834)
 + config: consistently format $variables in monospaced font
 (this branch uses jc/config-pathname-type.)

 Doc formatting fixes.


* bn/http-cookiefile-config (2016-05-04) 2 commits
  (merged to 'next' on 2016-05-09 at d519b13)
 + http: expand http.cookieFile as a path
 + Documentation: config: improve word ordering for http.cookieFile

 "http.cookieFile" configuration variable clearly wants a pathname,
 but we forgot to treat it as such by e.g. applying tilde expansion.


* es/test-gpg-tags (2016-05-09) 1 commit
  (merged to 'next' on 2016-05-10 at 9fcb98b)
 + t6302: simplify non-gpg cases

 Test fix.


* jc/config-pathname-type (2016-05-04) 1 commit
  (merged to 'next' on 2016-05-09 at 0876e55)
 + config: describe 'pathname' value type
 (this branch is used by bn/config-doc-tt-varnames.)

 Consolidate description of tilde-expansion that is done to
 configuration variables that take pathname to a single place.


* jc/fsck-nul-in-commit (2016-05-10) 2 commits
  (merged to 'next' on 2016-05-10 at 3bc3ca3)
 + fsck: detect and warn a commit with embedded NUL
 + fsck_commit_buffer(): do not special case the last validation

 "git fsck" learned to catch NUL byte in a commit object as
 potential error and warn.


* jc/linkgit-fix (2016-05-09) 1 commit
  (merged to 'next' on 2016-05-10 at 0e5ba60)
 + Documentation: fix linkgit references

 Many 'linkgit:<git documentation page>' references were broken,
 which are all fixed with this.


* jc/ll-merge-internal (2016-05-09) 3 commits
  (merged to 'next' on 2016-05-10 at a6bf1d0)
 + t6036: remove pointless test that expects failure
 + ll-merge: use a longer conflict marker for internal merge
 + ll-merge: fix typo in comment

 "git rerere" can get confused by conflict markers deliberately left
 by the inner merge step, because they are indistinguishable from
 the real conflict markers left by the outermost merge which are
 what the end user and "rerere" need to look at.  This was fixed by
 making the conflict markers left by the inner merges a bit longer.


* jc/test-seq (2016-05-09) 2 commits
  (merged to 'next' on 2016-05-10 at 1512890)
 + test-lib-functions.sh: rewrite test_seq without Perl
 + test-lib-functions.sh: remove misleading comment on test_seq

 Test fix.


* jk/rebase-interative-eval-fix (2016-05-10) 1 commit
  (merged to 'next' on 2016-05-11 at 4fdf387)
 + rebase--interactive: avoid empty list in shell for-loop

 Portability enhancement for "rebase -i" to help platforms whose
 shell does not like "for i in <empty>" (which is not POSIX-kosher).


* jk/submodule-c-credential (2016-05-06) 6 commits
  (merged to 'next' on 2016-05-10 at 4abe871)
 + submodule: stop sanitizing config options
 + submodule: use prepare_submodule_repo_env consistently
 + submodule--helper: move config-sanitizing to submodule.c
 + submodule: export sanitized GIT_CONFIG_PARAMETERS
 + t5550: break submodule config test into multiple sub-tests
 + t5550: fix typo in $HTTPD_URL
 (this branch is used by js/http-custom-headers.)

 An earlier addition of "sanitize_submodule_env" with 14111fc4 (git:
 submodule honor -c credential.* from command line, 2016-02-29)
 turned out to be a convoluted no-op; implement what it wanted to do
 correctly, and stop filtering settings given via "git -c var=val".


* jk/test-send-sh-x-trace-elsewhere (2016-05-11) 1 commit
  (merged to 'next' on 2016-05-11 at 273a137)
 + test-lib: set BASH_XTRACEFD automatically

 Running tests with '-x' option to trace the individual command
 executions is a useful way to debug test scripts, but some tests
 that capture the standard error stream and check what the command
 said can be broken with the trace output mixed in.  When running
 our tests under "bash", however, we can redirect the trace output
 to another file descriptor to keep the standard error of programs
 being tested intact.


* js/http-custom-headers (2016-05-10) 4 commits
  (merged to 'next' on 2016-05-10 at 7cf5cca)
 + submodule: ensure that -c http.extraheader is heeded
 + Merge branch 'jk/submodule-c-credential' into js/http-custom-headers
 + t5551: make the test for extra HTTP headers more robust
 + tests: adjust the configuration for Apache 2.2
 (this branch uses jk/submodule-c-credential.)

 Update tests for "http.extraHeaders=<header>" to be portable back
 to Apache 2.2 (the original depended on <RequireAll/> which is a
 more recent feature).


* js/t3404-typofix (2016-05-10) 1 commit
  (merged to 'next' on 2016-05-10 at cbeabc0)
 + t3404: fix typo

 Test fix.


* js/windows-dotgit (2016-05-11) 2 commits
  (merged to 'next' on 2016-05-11 at d10caa2)
 + mingw: remove unnecessary definition
 + mingw: introduce the 'core.hideDotFiles' setting

 On Windows, .git and optionally any files whose name starts with a
 dot are now marked as hidden, with a core.hideDotFiles knob to
 customize this behaviour.


* kf/gpg-sig-verification-doc (2016-05-13) 1 commit
  (merged to 'next' on 2016-05-13 at 2cec353)
 + Documentation: clarify signature verification

 Documentation for "git merge --verify-signatures" has been updated
 to clarify that the signature of only the commit at the tip is
 verified.  Also the phrasing used for signature and key validity is
 adjusted to align with that used by OpenPGP.


* lp/typofixes (2016-05-06) 1 commit
  (merged to 'next' on 2016-05-09 at 59683be)
 + typofix: assorted typofixes in comments, documentation and messages

 Typofixes.


* ls/travis-build-doc (2016-05-10) 1 commit
  (merged to 'next' on 2016-05-10 at 7f63497)
 + travis-ci: build documentation

 CI test was taught to build documentation pages.


* nd/error-errno (2016-05-09) 41 commits
  (merged to 'next' on 2016-05-10 at 1cdeda8)
 + wrapper.c: use warning_errno()
 + vcs-svn: use error_errno()
 + upload-pack.c: use error_errno()
 + unpack-trees.c: use error_errno()
 + transport-helper.c: use error_errno()
 + sha1_file.c: use {error,die,warning}_errno()
 + server-info.c: use error_errno()
 + sequencer.c: use error_errno()
 + run-command.c: use error_errno()
 + rerere.c: use error_errno() and warning_errno()
 + reachable.c: use error_errno()
 + mailmap.c: use error_errno()
 + ident.c: use warning_errno()
 + http.c: use error_errno() and warning_errno()
 + grep.c: use error_errno()
 + gpg-interface.c: use error_errno()
 + fast-import.c: use error_errno()
 + entry.c: use error_errno()
 + editor.c: use error_errno()
 + diff-no-index.c: use error_errno()
 + credential-cache--daemon.c: use warning_errno()
 + copy.c: use error_errno()
 + connected.c: use error_errno()
 + config.c: use error_errno()
 + compat/win32/syslog.c: use warning_errno()
 + combine-diff.c: use error_errno()
 + check-racy.c: use error_errno()
 + builtin/worktree.c: use error_errno()
 + builtin/upload-archive.c: use error_errno()
 + builtin/update-index.c: prefer "err" to "errno" in process_lstat_error
 + builtin/rm.c: use warning_errno()
 + builtin/pack-objects.c: use die_errno() and warning_errno()
 + builtin/merge-file.c: use error_errno()
 + builtin/mailsplit.c: use error_errno()
 + builtin/help.c: use warning_errno()
 + builtin/fetch.c: use error_errno()
 + builtin/branch.c: use error_errno()
 + builtin/am.c: use error_errno()
 + bisect.c: use die_errno() and warning_errno()
 + usage.c: add warning_errno() and error_errno()
 + usage.c: move format processing out of die_errno()

 The code for warning_errno/die_errno has been refactored and a new
 error_errno() reporting helper is introduced.


* nd/remote-plural-ours-plus-theirs (2016-05-06) 1 commit
  (merged to 'next' on 2016-05-10 at aea08dc)
 + remote.c: specify correct plural form in "commit diverge" message

 Message fix.


* nd/test-helpers (2016-05-10) 1 commit
  (merged to 'next' on 2016-05-10 at e8ad58d)
 + wrap-for-bin.sh: regenerate bin-wrappers when switching branches

 Switching between 'master' and 'next', between which the paths to
 test helper binaries have changed, did not update bin-wrappers/*
 scripts used in tests, causing false test failures.


* sb/submodule-deinit-all (2016-05-05) 1 commit
  (merged to 'next' on 2016-05-09 at 0fd4518)
 + submodule deinit: require '--all' instead of '.' for all submodules

 Correct faulty recommendation to use "git submodule deinit ." when
 de-initialising all submodules, which would result in a strange
 error message in a pathological corner case.


* sb/submodule-init (2016-05-03) 7 commits
  (merged to 'next' on 2016-05-03 at 8a5fce4)
 + submodule init: redirect stdout to stderr
  (merged to 'next' on 2016-04-29 at 3e81ee88)
 + submodule--helper update-clone: abort gracefully on missing .gitmodules
 + submodule init: fail gracefully with a missing .gitmodules file
  (merged to 'next' on 2016-04-27 at afaad81)
 + submodule: port init from shell to C
 + submodule: port resolve_relative_url from shell to C
 + Merge branch 'sb/submodule-path-misc-bugs' into sb/submodule-init
 + Merge branch 'sb/submodule-helper-clone-regression-fix' into sb/submodule-init

 Update of "git submodule" to move pieces of logic to C continues.


* sb/z-is-gnutar-ism (2016-05-09) 2 commits
  (merged to 'next' on 2016-05-09 at 51d527d)
 + t6041: do not compress backup tar file
 + t3513: do not compress backup tar file

 Test fix.


* tb/t5601-sed-fix (2016-05-09) 1 commit
  (merged to 'next' on 2016-05-10 at d3e54e8)
 + t5601: Remove trailing space in sed expression

 Test fix.


* va/i18n-misc-updates (2016-05-12) 10 commits
  (merged to 'next' on 2016-05-13 at 0361b16)
 + i18n: unpack-trees: avoid substituting only a verb in sentences
  (merged to 'next' on 2016-05-10 at b5dbd0d)
 + i18n: builtin/pull.c: split strings marked for translation
 + i18n: builtin/pull.c: mark placeholders for translation
 + i18n: git-parse-remote.sh: mark strings for translation
 + i18n: branch: move comment for translators
 + i18n: branch: unmark string for translation
 + i18n: builtin/rm.c: remove a comma ',' from string
 + i18n: unpack-trees: mark strings for translation
 + i18n: builtin/branch.c: mark option for translation
 + i18n: index-pack: use plural string instead of normal one

 Mark several messages for translation.


* va/i18n-remote-comment-to-align (2016-05-09) 1 commit
  (merged to 'next' on 2016-05-10 at edbacbb)
 + i18n: remote: add comment for translators

 Message fix.


* va/mailinfo-doc-typofix (2016-05-11) 1 commit
  (merged to 'next' on 2016-05-11 at 7180176)
 + Documentation/git-mailinfo: fix typo

 Typofix.

--------------------------------------------------
[New Topics]

* da/difftool (2016-05-16) 2 commits
  (merged to 'next' on 2016-05-17 at ef5a435)
 + difftool: handle unmerged files in dir-diff mode
 + difftool: initialize variables for readability

 "git difftool" learned to handle unmerged paths correctly in
 dir-diff mode.

 Will merge to 'master'.


* jc/attr (2016-05-17) 14 commits
 - SQUASH???
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct git_attr_check"
 - attr: (re)introduce git_check_attr() and struct git_attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.


* fc/fast-import-broken-marks-file (2016-05-17) 1 commit
 - fast-import: do not truncate exported marks file

 "git fast-import --export-marks" would overwrite the existing marks
 file even when it makes a dump from its custom die routine.
 Prevent it from doing so when we have an import-marks file but
 haven't finished reading it. 

--------------------------------------------------
[Stalled]

* ep/http-curl-trace (2016-05-02) 2 commits
 . imap-send.c: introduce the GIT_TRACE_CURL environment variable
 . http.c: implement the GIT_TRACE_CURL environment variable

 HTTP transport gained an option to produce more detailed debugging
 trace.

 Expecting a reroll.
 ($gmane/292074, 293236)


* sb/bisect (2016-04-15) 22 commits
 - SQUASH???
 - bisect: get back halfway shortcut
 - bisect: compute best bisection in compute_relevant_weights()
 - bisect: use a bottom-up traversal to find relevant weights
 - bisect: prepare for different algorithms based on find_all
 - bisect: rename count_distance() to compute_weight()
 - bisect: make total number of commits global
 - bisect: introduce distance_direction()
 - bisect: extract get_distance() function from code duplication
 - bisect: use commit instead of commit list as arguments when appropriate
 - bisect: replace clear_distance() by unique markers
 - bisect: use struct node_data array instead of int array
 - bisect: get rid of recursion in count_distance()
 - bisect: make algorithm behavior independent of DEBUG_BISECT
 - bisect: make bisect compile if DEBUG_BISECT is set
 - bisect: plug the biggest memory leak
 - bisect: add test for the bisect algorithm
 - t6030: generalize test to not rely on current implementation
 - t: use test_cmp_rev() where appropriate
 - t/test-lib-functions.sh: generalize test_cmp_rev
 - bisect: allow 'bisect run' if no good commit is known
 - bisect: write about `bisect next` in documentation

 The internal algorithm used in "git bisect" to find the next commit
 to check has been optimized greatly.

 Expecting a reroll.
 ($gmane/291163)


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


* sg/completion-updates (2016-02-28) 21 commits
 . completion: cache the path to the repository
 . completion: extract repository discovery from __gitdir()
 . completion: don't guard git executions with __gitdir()
 . completion: consolidate silencing errors from git commands
 . completion: don't use __gitdir() for git commands
 . completion: respect 'git -C <path>'
 . completion: fix completion after 'git -C <path>'
 . completion: don't offer commands when 'git --opt' needs an argument
 . rev-parse: add '--absolute-git-dir' option
 . completion: list short refs from a remote given as a URL
 . completion: don't list 'HEAD' when trying refs completion outside of a repo
 . completion: list refs from remote when remote's name matches a directory
 . completion: respect 'git --git-dir=<path>' when listing remote refs
 . completion: fix most spots not respecting 'git --git-dir=<path>'
 . completion: ensure that the repository path given on the command line exists
 . completion tests: add tests for the __git_refs() helper function
 . completion tests: check __gitdir()'s output in the error cases
 . completion tests: consolidate getting path of current working directory
 . completion tests: make the $cur variable local to the test helper functions
 . completion tests: don't add test cruft to the test repository
 . completion: improve __git_refs()'s in-code documentation

 Will be rerolled.
 ($gmane/287839)


* az/p4-bare-no-rebase (2016-02-19) 1 commit
 - git-p4.py: Don't try to rebase on submit from bare repository

 "git p4 submit" attempts to do a rebase, which would fail if done
 in a bare repository.  Not doing this rebase would paper over the
 failure, which is what this patch does, but it is unclear what the
 side effect of not rebasing is.

 Needs a better explanation.


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

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.

 Will be rerolled.
 ($gmane/292205)


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


* jc/merge-impossible-no-commit (2016-04-26) 2 commits
 - merge: warn --no-commit merge when no new commit is created
 - merge: do not contaminate option_commit with --squash

 "git merge --no-commit" silently succeeded when there is no need to
 create any commit, either when you are more recent than the commit
 you tried to merge, or you can fast-forward to the commit you tried
 to merge.  The command gives a warning message in such cases.

 Just tying loose ends in a discussion.  Unless somebody else
 champions this topic, I'll drop it.

 Will discard.

--------------------------------------------------
[Cooking]

* es/t1500-modernize (2016-05-17) 5 commits
 - t1500: avoid setting environment variables outside of tests
 - t1500: avoid setting configuration options outside of tests
 - t1500: avoid changing working directory outside of tests
 - t1500: test_rev_parse: facilitate future test enhancements
 - t1500: be considerate to future potential tests

 test updates to make it more readable and maintainable.


* jc/rerere-multi (2016-05-11) 1 commit
  (merged to 'next' on 2016-05-13 at f4d1d82)
 + rerere: plug memory leaks upon "rerere forget" failure

 Will merge to 'master'.


* cc/apply-introduce-state (2016-05-12) 48 commits
 - builtin/apply: rename 'prefix_' parameter to 'prefix'
 - builtin/apply: move applying patches into apply_all_patches()
 - builtin/apply: move 'state' check into check_apply_state()
 - builtin/apply: move 'symlink_changes' global into 'struct apply_state'
 - builtin/apply: move 'fn_table' global into 'struct apply_state'
 - builtin/apply: move 'state_linenr' global into 'struct apply_state'
 - builtin/apply: move 'max_change' and 'max_len' into 'struct apply_state'
 - builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
 - builtin/apply: move 'ws_error_action' into 'struct apply_state'
 - builtin/apply: move 'applied_after_fixing_ws' into 'struct apply_state'
 - builtin/apply: move 'squelch_whitespace_errors' into 'struct apply_state'
 - builtin/apply: remove whitespace_option arg from set_default_whitespace_mode()
 - builtin/apply: move 'whitespace_option' into 'struct apply_state'
 - builtin/apply: move 'whitespace_error' global into 'struct apply_state'
 - builtin/apply: move 'root' global into 'struct apply_state'
 - builtin/apply: move 'p_value_known' global into 'struct apply_state'
 - builtin/apply: move 'p_value' global into 'struct apply_state'
 - builtin/apply: move 'has_include' global into 'struct apply_state'
 - builtin/apply: move 'limit_by_name' global into 'struct apply_state'
 - builtin/apply: move 'patch_input_file' global into 'struct apply_state'
 - builtin/apply: move 'apply' global into 'struct apply_state'
 - builtin/apply: move 'p_context' global into 'struct apply_state'
 - builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
 - builtin/apply: move 'line_termination' global into 'struct apply_state'
 - builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
 - builtin/apply: move 'no_add' global into 'struct apply_state'
 - builtin/apply: move 'threeway' global into 'struct apply_state'
 - builtin/apply: move 'summary' global into 'struct apply_state'
 - builtin/apply: move 'numstat' global into 'struct apply_state'
 - builtin/apply: move 'diffstat' global into 'struct apply_state'
 - builtin/apply: move 'cached' global into 'struct apply_state'
 - builtin/apply: move 'allow_overlap' global into 'struct apply_state'
 - builtin/apply: move 'update_index' global into 'struct apply_state'
 - builtin/apply: move 'apply_verbosely' global into 'struct apply_state'
 - builtin/apply: move 'apply_with_reject' global into 'struct apply_state'
 - builtin/apply: move 'apply_in_reverse' global into 'struct apply_state'
 - builtin/apply: move 'check_index' global into 'struct apply_state'
 - builtin/apply: move 'check' global into 'struct apply_state'
 - builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
 - builtin/apply: move 'state' init into init_apply_state()
 - builtin/apply: introduce 'struct apply_state' to start libifying
 - builtin/apply: move 'read_stdin' global into cmd_apply()
 - builtin/apply: move 'options' variable into cmd_apply()
 - builtin/apply: extract line_by_line_fuzzy_match() from match_fragment()
 - builtin/apply: avoid local variable shadowing 'len' parameter
 - builtin/apply: avoid parameter shadowing 'linenr' global
 - builtin/apply: avoid parameter shadowing 'p_value' global
 - builtin/apply: make gitdiff_verify_name() return void

 The "git apply" standalone program is being libified; this is the
 first step to move many state variables into a structure that can
 be explicitly (re)initialized to make the machinery callable more
 than once.

 The next step that moves some remaining state variables into the
 structure and turns die()s into an error return that propagates up
 to the caller is not queued yet but in flight.  It would be good to
 review the above first and give the remainder of the series a solid
 base to build on.

 Will be rerolled.


* jk/test-z-n-unquoted (2016-05-14) 6 commits
  (merged to 'next' on 2016-05-17 at 65372cf)
 + always quote shell arguments to test -z/-n
 + t9103: modernize test style
 + t9107: switch inverted single/double quotes in test
 + t9107: use "return 1" instead of "exit 1"
 + t9100,t3419: enclose all test code in single-quotes
 + t/lib-git-svn: drop $remote_git_svn and $git_svn_id

 t9xxx series has been updated primarily for readability, while
 fixing small bugs in it.  A few scripted Porcelains have also been
 updated to fix possible bugs around their use of "test -z" and
 "test -n".

 Will merge to 'master'.


* pb/bisect (2016-05-13) 4 commits
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Beginning of GSoC "git bisect" project.


* sb/pathspec-label (2016-05-14) 5 commits
 . pathspec: record labels
 . pathspec: move prefix check out of the inner loop
 . pathspec: move long magic parsing out of prefix_pathspec
 . Documentation: correct typo in example for querying attributes
 . Documentation: fix a typo

 The pathspec mechanism learned ":(label=X)$pattern" pathspec magic
 to limit paths that match $pattern further by labels defined by the
 attributes mechanism for the paths.

 (RFC/WIP)


* ar/diff-args-osx-precompose (2016-05-13) 1 commit
  (merged to 'next' on 2016-05-17 at 7b59b79)
 + diff: run arguments through precompose_argv

 Many commands normalize command line arguments from NFD to NFC
 variant of UTF-8 on OSX, but commands in the "diff" family did
 not, causing "git diff $path" to complain that no such path is
 known to Git.  They have been taught to do the normalization.

 Will merge to 'master'.


* js/perf-rebase-i (2016-05-13) 3 commits
  (merged to 'next' on 2016-05-13 at eb51ddd)
 + perf: run "rebase -i" under perf
 + perf: make the tests work in worktrees
 + perf: let's disable symlinks when they are not available

 Add perf test for "rebase -i"

 Will merge to 'master'.


* nd/worktree-cleanup-post-head-protection (2016-05-10) 7 commits
 - worktree: simplify prefixing paths
 - worktree: avoid 0{40}, too many zeroes, hard to read
 - worktree.c: add clear_worktree()
 - worktree.c: use is_dot_or_dotdot()
 - git-worktree.txt: keep subcommand listing in alphabetical order
 - worktree.c: rewrite mark_current_worktree() to avoid strbuf
 - completion: support git-worktree
 (this branch uses nd/worktree-various-heads.)

 Further preparatory clean-up for "worktree" feature.

 Expecting a reroll.
 ($gmane/294136, etc.)


* ss/commit-dry-run-resolve-merge-to-no-op (2016-02-17) 1 commit
  (merged to 'next' on 2016-05-10 at 2ada404)
 + wt-status.c: set commitable bit if there is a meaningful merge.

 "git commit --dry-run" reported "No, no, you cannot commit." in one
 case where "git commit" would have allowed you to commit, and this
 improves it a little bit ("git commit --dry-run --short" still does
 not give you the correct answer, for example).  This is a stop-gap
 measure in that "commit --short --dry-run" still gives an incorrect
 result.

 Will merge to 'master'.


* tb/core-eol-fix (2016-04-25) 4 commits
  (merged to 'next' on 2016-05-10 at fa8a200)
 + convert.c: ident + core.autocrlf didn't work
 + t0027: test cases for combined attributes
 + convert: allow core.autocrlf=input and core.eol=crlf
 + t0027: make commit_chk_wrnNNO() reliable

 A couple of bugs around core.autocrlf have been fixed.

 Will merge to 'master'.


* jc/test-parse-options-expect (2016-05-10) 4 commits
  (merged to 'next' on 2016-05-10 at 3ca5783)
 + t0040: convert a few tests to use test-parse-options --expect
 + t0040: remove unused test helpers
 + test-parse-options: --expect=<string> option to simplify tests
 + test-parse-options: fix output when callback option fails
 (this branch uses pb/commit-verbose-config.)

 t0040 had too many unnecessary repetitions in its test data.  Teach
 test-parse-options program so that a caller can tell what it
 expects in its output, so that these repetitions can be cleaned up.

 Will merge to 'master'.


* jc/doc-lint (2016-05-10) 1 commit
  (merged to 'next' on 2016-05-17 at 9032aa5)
 + ci: validate "linkgit:" in documentation

 Find common mistakes when writing gitlink: in our documentation and
 drive the check from "make check-docs".

 I am not entirely happy with the way the script chooses what input
 file to validate, but it is not worse than not having anything, so
 let's move it forward and have the logic improved later when people
 care about it deeply.

 Will merge to 'master'.


* jk/push-client-deadlock-fix (2016-05-11) 2 commits
  (merged to 'next' on 2016-05-11 at 8f4abf9)
 + Windows: only add a no-op pthread_sigmask() when needed
  (merged to 'next' on 2016-05-06 at e91626c)
 + Windows: add pthread_sigmask() that does nothing

 Some Windows SDK lacks pthread_sigmask() implementation and fails
 to compile the recently updated "git push" codepath that uses it.

 Will merge to 'master'.


* mh/split-under-lock (2016-05-13) 33 commits
 - lock_ref_sha1_basic(): only handle REF_NODEREF mode
 - commit_ref_update(): remove the flags parameter
 - lock_ref_for_update(): don't resolve symrefs
 - lock_ref_for_update(): don't re-read non-symbolic references
 - refs: resolve symbolic refs first
 - ref_transaction_update(): check refname_is_safe() at a minimum
 - unlock_ref(): move definition higher in the file
 - lock_ref_for_update(): new function
 - add_update(): initialize the whole ref_update
 - verify_refname_available(): adjust constness in declaration
 - refs: don't dereference on rename
 - refs: allow log-only updates
 - delete_branches(): use resolve_refdup()
 - ref_transaction_commit(): correctly report close_ref() failure
 - ref_transaction_create(): disallow recursive pruning
 - refs: make error messages more consistent
 - lock_ref_sha1_basic(): remove unneeded local variable
 - read_raw_ref(): move docstring to header file
 - read_raw_ref(): improve docstring
 - read_raw_ref(): rename symref argument to referent
 - read_raw_ref(): clear *type at start of function
 - read_raw_ref(): rename flags argument to type
 - ref_transaction_commit(): remove local variable n
 - rename_ref(): remove unneeded local variable
 - commit_ref_update(): write error message to *err, not stderr
 - refname_is_safe(): insist that the refname already be normalized
 - refname_is_safe(): don't allow the empty string
 - refname_is_safe(): use skip_prefix()
 - remove_dir_recursively(): add docstring
 - safe_create_leading_directories(): improve docstring
 - read_raw_ref(): don't get confused by an empty directory
 - commit_ref(): if there is an empty dir in the way, delete it
 - t1404: demonstrate a bug resolving references

 Further preparatory work on the refs API before the pluggable
 backend series can land.

 Updated (again).  Will wait for comments for the last time, and
 then merge to 'next'.


* mh/connect-leak (2016-04-28) 1 commit
 - git_connect(): fix memory leak with CONNECT_DIAG_URL

 Is already made obsolete with a patch in flight under discussion.
 ($gmane/292962)

 Will discard.


* ew/fast-import-unpack-limit (2016-05-11) 1 commit
  (merged to 'next' on 2016-05-11 at ffd4efb)
 + fast-import: implement unpack limit

 "git fast-import" learned the same performance trick to avoid
 creating too small a packfile as "git fetch" and "git push" have,
 using *.unpackLimit configuration.

 Will merge to 'master'.


* nd/worktree-various-heads (2016-04-22) 13 commits
  (merged to 'next' on 2016-05-10 at 61d3415)
 + branch: do not rename a branch under bisect or rebase
 + worktree.c: check whether branch is bisected in another worktree
 + wt-status.c: split bisect detection out of wt_status_get_state()
 + worktree.c: check whether branch is rebased in another worktree
 + worktree.c: avoid referencing to worktrees[i] multiple times
 + wt-status.c: make wt_status_check_rebase() work on any worktree
 + wt-status.c: split rebase detection out of wt_status_get_state()
 + path.c: refactor and add worktree_git_path()
 + worktree.c: mark current worktree
 + worktree.c: make find_shared_symref() return struct worktree *
 + worktree.c: store "id" instead of "git_dir"
 + path.c: add git_common_path() and strbuf_git_common_path()
 + dir.c: rename str(n)cmp_icase to fspath(n)cmp
 (this branch is used by nd/worktree-cleanup-post-head-protection.)

 The experimental "multiple worktree" feature gains more safety to
 forbid operations on a branch that is checked out or being actively
 worked on elsewhere, by noticing that e.g. it is being rebased.

 Will merge to 'master'.


* pb/commit-verbose-config (2016-05-10) 7 commits
 + commit: add a commit.verbose config variable
 + t7507-commit-verbose: improve test coverage by testing number of diffs
 + parse-options.c: make OPTION_COUNTUP respect "unspecified" values
 + t/t7507: improve test coverage
 + t0040-parse-options: improve test coverage
 + test-parse-options: print quiet as integer
 + t0040-test-parse-options.sh: fix style issues
 (this branch is used by jc/test-parse-options-expect.)

 "git commit" learned to pay attention to "commit.verbose"
 configuration variable and act as if "--verbose" option was
 given from the command line.

 Will merge to 'master'.


* jc/send-email-skip-backup (2016-04-12) 1 commit
 - send-email: detect and offer to skip backup files

 A careless invocation of "git send-email directory/" after editing
 0001-change.patch with an editor often ends up sending both
 0001-change.patch and its backup file, 0001-change.patch~, causing
 embarrassment and a minor confusion.  Detect such an input and
 offer to skip the backup files when sending the patches out.

 Needs review.


* kn/ref-filter-branch-list (2016-05-17) 17 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add `:dir` and `:base` options for ref printing atoms
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce symref_atom_parser() and refname_atom_parser()
 - ref-filter: introduce refname_atom_parser_internal()
 - ref-filter: make "%(symref)" atom work with the ':short' modifier
 - ref-filter: add support for %(upstream:track,nobracket)
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: move get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: include reference to 'used_atom' within 'atom_value'
 - ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Rerolled.
 Needs review.


* xy/format-patch-base (2016-04-26) 4 commits
  (merged to 'next' on 2016-05-10 at dd19e0a)
 + format-patch: introduce format.useAutoBase configuration
 + format-patch: introduce --base=auto option
 + format-patch: add '--base' option to record base tree info
 + patch-ids: make commit_patch_id() a public helper function

 "git format-patch" learned a new "--base" option to record what
 (public, well-known) commit the original series was built on in
 its output.

 Will merge to 'master'.


* dt/index-helper (2016-05-13) 20 commits
 - untracked-cache: config option
 - trace: measure where the time is spent in the index-heavy operations
 - index-helper: optionally automatically run
 - index-helper: autorun mode
 - index-helper: don't run if already running
 - index-helper: kill mode
 - watchman: add a config option to enable the extension
 - unpack-trees: preserve index extensions
 - update-index: enable/disable watchman support
 - index-helper: use watchman to avoid refreshing index with lstat()
 - watchman: support watchman to reduce index refresh cost
 - read-cache: add watchman 'WAMA' extension
 - index-helper: log warnings
 - index-helper: add --detach
 - daemonize(): set a flag before exiting the main process
 - index-helper: add --strict
 - index-helper: new daemon for caching index and related stuff
 - pkt-line: add gentle version of packet_write
 - read-cache: allow to keep mmap'd memory after reading
 - read-cache.c: fix constness of verify_hdr()

 A new "index-helper" daemon has been introduced to give newly
 spawned Git process a quicker access to the data in the index, and
 optionally interface with the watchman daemon to further reduce the
 refresh cost.

 Under review.
 ($gmane/294470).


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


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 ($gmane/282594)

--------------------------------------------------
[Discarded]

* jc/diff-compact-always-use-blank-heuristics (2016-04-29) 1 commit
 . diff: enable "compaction heuristics" and lose experimentation knob

 Superseded by the tip commit on the jk/diff-compact-heuristic topic.
