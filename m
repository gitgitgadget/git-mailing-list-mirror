From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2016, #01; Tue, 3)
Date: Tue, 03 May 2016 15:49:27 -0700
Message-ID: <xmqqshxykb9k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 00:49:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axj8K-0007NL-MJ
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbcECWtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:49:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756519AbcECWtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:49:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C805715065;
	Tue,  3 May 2016 18:49:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=q
	CLw3Jd89tG7rD3v8Mh0j1m4/t0=; b=noOswQkSwmBpCD/2T2+D+1doc6FxApzvt
	FEnPUOTgYlKlwZYooXty1ydcq4Rmb9SHtMcPHKR+UOA32g3JznJ/L1xFjE3m8ILy
	v0qZfJEs5ivN110eUrqssSqJrLmJMj8VaN+GT/aQ5scV/I20VZrbu8RSUt1F5jMa
	BOb9xg5Bps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=jIk
	ibrJAFDB2sF9KSGimgZiAcxaNWU/ZihLc263l6enYSIDU7Wq3GyWtdqHUmwNm804
	+qLVesBas2U4CgkRtrIhG8P7TmbFXORm0JGsRDHIDpXuNND6UYRF61PWKVfaTSN0
	PmN9XbWVkcvKbAq7fPQxCEyEahnqMvG+soCgXWcM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF90715064;
	Tue,  3 May 2016 18:49:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C847115063;
	Tue,  3 May 2016 18:49:28 -0400 (EDT)
X-master-at: 4bb51aed1e858bfac174255ae4d8994af3a8e07a
X-next-at: d223320ae286a25b183b0959b1a0160871c6684a
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B02E9A8-1181-11E6-BB9D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293473>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The 'master' branch now has the ninth batch of topics of this cycle.
On the 'maint' front, 2.8.2 is out and fixes that have been in
'master' accumulates on it for 2.8.3.

Ones with questionable status has a '?' character in their comments.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* en/merge-fixes (2016-04-12) 2 commits
  (merged to 'next' on 2016-04-27 at 14d7d10)
 + merge-recursive: do not check working copy when creating a virtual merge base
 + merge-recursive: remove duplicate code

 "merge-recursive" strategy incorrectly checked if a path that is
 involved in its internal merge exists in the working tree.


* jd/p4-jobs-in-commit (2016-04-19) 2 commits
  (merged to 'next' on 2016-04-27 at 654d946)
 + git-p4: add P4 jobs to git commit message
 + git-p4: clean-up code style in tests

 "git p4" learned to record P4 jobs in Git commit that imports from
 the history in Perforce.


* jd/send-email-to-whom (2016-04-25) 1 commit
  (merged to 'next' on 2016-04-27 at 47ae363)
 + send-email: fix grammo in the prompt that asks e-mail recipients

 A question by "git send-email" to ask the identity of the sender
 has been updated.


* jk/fix-attribute-macro-in-2.5 (2016-04-25) 1 commit
  (merged to 'next' on 2016-04-27 at 2e42613)
 + remote.c: spell __attribute__ correctly

 Code fixup.


* js/name-rev-use-oldest-ref (2016-04-22) 1 commit
  (merged to 'next' on 2016-04-27 at 8fdc0ac)
 + name-rev: include taggerdate in considering the best name

 "git describe --contains" often made a hard-to-justify choice of
 tag to give name to a given commit, because it tried to come up
 with a name with smallest number of hops from a tag, causing an old
 commit whose close descendant that is recently tagged were not
 described with respect to an old tag but with a newer tag.  It did
 not help that its computation of "hop" count was further tweaked to
 penalize being on a side branch of a merge.  The logic has been
 updated to favor using the tag with the oldest tagger date, which
 is a lot easier to explain to the end users: "We describe a commit
 in terms of the (chronologically) oldest tag that contains the
 commit."


* nd/remove-unused (2016-04-22) 2 commits
  (merged to 'next' on 2016-04-27 at 7917efa)
 + wrapper.c: delete dead function git_mkstemps()
 + dir.c: remove dead function fnmatch_icase()

 Code cleanup.


* nf/mergetool-prompt (2016-04-25) 1 commit
  (merged to 'next' on 2016-04-27 at 1c992df)
 + difftool/mergetool: make the form of yes/no questions consistent

 UI consistency improvements.


* rt/string-list-lookup-cleanup (2016-04-25) 1 commit
  (merged to 'next' on 2016-04-27 at 53514e1)
 + string_list: use string-list API in unsorted_string_list_lookup()

 Code cleanup.


* sg/test-lib-simplify-expr-away (2016-04-22) 1 commit
  (merged to 'next' on 2016-04-27 at 8f40952)
 + test-lib: simplify '--option=value' parsing

 Code cleanup.

--------------------------------------------------
[New Topics]

* ew/normal-to-e (2016-05-02) 1 commit
 - .mailmap: update to my shorter email address

 Will merge to 'next'.


* jc/diff-compact-always-use-blank-heuristics (2016-04-29) 3 commits
 - diff: enable "compaction heuristics" and lose experimentation knob
  (merged to 'next' on 2016-04-22 at 0c117ea)
 + xdiff: implement empty line chunk heuristic
 + xdiff: add recs_match helper function
 (this branch is tangled with jk/diff-compact-heuristic.)

 This should be discarded.


* js/close-packs-before-gc (2016-05-02) 1 commit
 - t5510: run auto-gc in the foreground

 Will merge to 'next'.


* ls/travis-submitting-patches (2016-05-02) 1 commit
 - Documentation: add setup instructions for Travis CI

 Will merge to 'next'.


* rn/glossary-typofix (2016-05-02) 1 commit
 - Documentation: fix typo 'In such these cases'

 Will merge to 'next'.


* jc/commit-tree-ignore-commit-gpgsign (2016-05-03) 1 commit
 - commit-tree: do not pay attention to commit.gpgsign

 "git commit-tree" plumbing command required the user to always sign
 its result when the user sets the commit.gpgsign configuration
 variable, which was an ancient mistake.  Rework "git rebase" that
 relied on this mistake so that it reads commit.gpgsign and pass (or
 not pass) the -S option to "git commit-tree" to keep the end-user
 expectation the same, while teaching "git commit-tree" to ignore
 the configuration variable.  This will stop requiring the users to
 sign commit objects used internally as an implementation detail of
 "git stash".

 Will merge to 'next'.


* jk/push-client-deadlock-fix (2016-05-02) 1 commit
 - Windows: add pthread_sigmask() that does nothing

 Will merge to 'next'.


* sb/clean-test-fix (2016-05-03) 1 commit
 - t7300: mark test with SANITY

 Will merge to 'next'.


* sb/submodule-module-list-pathspec-fix (2016-05-03) 1 commit
 - submodule deinit test: fix broken && chain in subshell

 Will merge to 'next'.


* sk/gitweb-highlight-encoding (2016-05-03) 1 commit
 - gitweb: apply fallback encoding before highlight

 Some multi-byte encoding can have a backslash byte as a later part
 of one letter, which would confuse "highlight" filter used in
 gitweb.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* ar/diff-args-osx-precompose (2016-04-05) 1 commit
 - diff: run arguments through precompose_argv

 Many commands normalize command line arguments from NFD to NFC
 variant of UTF-8 on OSX, but commands in the "diff" family did
 not, causing "git diff $path" to complain that no such path is
 known to Git.  They have been taught to do the normalization.

 Will this be rerolled?
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

--------------------------------------------------
[Cooking]

* ab/hooks (2016-04-26) 4 commits
 - hooks: allow customizing where the hook directory is
 - githooks.txt: minor improvements to the grammar & phrasing
 - githooks.txt: amend dangerous advice about 'update' hook ACL
 - githooks.txt: improve the intro section

 A new configuration variable core.hooksPath allows customizing
 where the hook directory is.

 Almost there.
 ($gmane/292635)


* jc/merge-impossible-no-commit (2016-04-26) 2 commits
 - merge: warn --no-commit merge when no new commit is created
 - merge: do not contaminate option_commit with --squash

 "git merge --no-commit" silently succeeded when there is no need to
 create any commit, either when you are more recent than the commit
 you tried to merge, or you can fast-forward to the commit you tried
 to merge.  The command gives a warning message in such cases.

 Just tying loose ends in a discussion.  Unless somebody else
 champions this topic, I'll drop it.


* js/http-custom-headers (2016-04-27) 1 commit
  (merged to 'next' on 2016-04-27 at 0c97a50)
 + http: support sending custom HTTP headers

 HTTP transport clients learned to throw extra HTTP headers at the
 server, specified via http.extraHeader configuration variable.

 Will merge to 'master'.


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


* sb/config-exit-status-list (2016-04-26) 1 commit
  (merged to 'next' on 2016-04-27 at 44fe343)
 + config doc: improve exit code listing

 Doc update.

 Will merge to 'master'.


* mh/split-under-lock (2016-04-27) 29 commits
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

 Further preparatory work on the refs API before the pluggable
 backend series can land.

 Almost there.
 ($gmane/292772)


* bn/http-cookiefile-config (2016-04-29) 2 commits
 - http: expand http.cookieFile as a path
 - Documentation: config: improve word ordering for http.cookieFile
 (this branch uses jc/config-pathname-type.)

 "http.cookieFile" configuration variable clearly wants a pathname,
 but we forgot to treat it as such by e.g. applying tilde expansion.

 Waiting for an Ack to what's queued with tweaks, or a reroll.
 ($gmane/292969)


* ew/doc-split-pack-disables-bitmap (2016-04-28) 1 commit
 - pack-objects: warn on split packs disabling bitmaps

 Doc update.

 Will merge to 'next'.


* jc/config-pathname-type (2016-04-29) 1 commit
 - config: describe 'pathname' value type
 (this branch is used by bn/http-cookiefile-config.)

 Consolidate description of tilde-expansion that is done to
 configuration variables that take pathname to a single place.

 Will merge to 'next'.


* jk/submodule-config-sanitize-fix (2016-04-28) 5 commits
 - submodule: use prepare_submodule_repo_env consistently
 - submodule--helper: move config-sanitizing to submodule.c
 - submodule: export sanitized GIT_CONFIG_PARAMETERS
 - t5550: break submodule config test into multiple sub-tests
 - t5550: fix typo in $HTTPD_URL

 An earlier addition of "sanitize_submodule_env" with 14111fc4 (git:
 submodule honor -c credential.* from command line, 2016-02-29)
 turned out to be a convoluted no-op; implement what it wanted to do
 correctly.

 With a rethink of the merit of "sanitization" going on, we may end
 up doing the configuration propagation very differently, though.

 Will hold.


* mh/connect-leak (2016-04-28) 1 commit
 - git_connect(): fix memory leak with CONNECT_DIAG_URL

 Is already made obsolete with a patch in flight under discussion.
 ($gmane/292962)

 Will discard.


* sb/misc-cleanups (2016-04-28) 2 commits
 - submodule-config: don't shadow `cache`
 - config.c: drop local variable

 Will merge to 'next'.


* ew/fast-import-unpack-limit (2016-04-24) 1 commit
 - fast-import: implement unpack limit

 "git fast-import" learned the same performance trick to avoid
 creating too small a packfile as "git fetch" and "git push" have,
 using *.unpackLimit configuration.

 Need to pick up the rerolled version.
 ($gmane/292562)


* ld/p4-test-py3 (2016-04-26) 3 commits
  (merged to 'next' on 2016-04-27 at d5d5fca)
 + git-p4 tests: time_in_seconds should use $PYTHON_PATH
 + git-p4 tests: work with python3 as well as python2
 + git-p4 tests: cd to / before running python

 The test scripts for "git p4" (but not "git p4" implementation
 itself) has been updated so that they would work even on a system
 where the installed version of Python is python 3.

 Will merge to 'master'.


* ls/p4-lfs-test-fix-2.7.0 (2016-04-29) 2 commits
  (merged to 'next' on 2016-04-29 at da56b67)
 + t9824: fix wrong reference value
  (merged to 'next' on 2016-04-27 at be87c63)
 + t9824: fix broken &&-chain in a subshell

 Fix a broken test.

 Will merge to 'master'.


* sb/clone-shallow-passthru (2016-04-26) 1 commit
  (merged to 'next' on 2016-04-27 at 3112b24)
 + clone: add `--shallow-submodules` flag

 "git clone" learned "--shallow-submodules" option.

 Will merge to 'master'.


* ls/p4-lfs (2016-04-28) 3 commits
 - git-p4: fix Git LFS pointer parsing
 - travis-ci: express Linux/OS X dependency versions more clearly
 - travis-ci: update Git-LFS and P4 to the latest version

 Recent update to Git LFS broke "git p4" by changing the output from
 its "lfs pointer" subcommand.

 Will merge to 'next'.


* tb/convert-eol-autocrlf (2016-04-29) 10 commits
 - ce_compare_data() did not respect conversion
 - t6038; use crlf on all platforms
 - convert.c: more safer crlf handling with text attribute
 - convert: unify the "auto" handling of CRLF
 - convert.c: stream and early out
 - read-cache: factor out get_sha1_from_index() helper
 - convert.c: ident + core.autocrlf didn't work
 - t0027: test cases for combined attributes
 - convert: allow core.autocrlf=input and core.eol=crlf
 - t0027: make commit_chk_wrnNNO() reliable

 The combination of text=auto & eol=crlf (or eol=lf for that matter)
 is taught to be much more useful; it used to be "auto detection"
 was defeated as if setting eol declares that the file _is_ text,
 but now text=auto is still in effect for such a path and the code
 refrains from applying eol conversion if it found the path is not
 text.  Also setting core.autocrlf to 'input' and core.eol to 'crlf'
 used to be rejected, but because the code gives precedence to
 core.autocrlf, there is no need to, hence we no longer reject the
 combination.

 Earlier steps looked alright, but it veers into a wrong direction
 in the middle.


* bc/object-id (2016-04-25) 6 commits
  (merged to 'next' on 2016-04-29 at 02f13a4)
 + match-trees: convert several leaf functions to use struct object_id
 + tree-walk: convert tree_entry_extract() to use struct object_id
 + struct name_entry: use struct object_id instead of unsigned char sha1[20]
 + match-trees: convert shift_tree() and shift_tree_by() to use object_id
 + test-match-trees: convert to use struct object_id
 + sha1-name: introduce a get_oid() function

 Move from unsigned char[20] to struct object_id continues.

 Will merge to 'master'.


* ep/http-curl-trace (2016-05-02) 2 commits
 . imap-send.c: introduce the GIT_TRACE_CURL environment variable
 . http.c: implement the GIT_TRACE_CURL environment variable

 HTTP transport gained an option to produce more detailed debugging
 trace.

 Still under discussion.
 ($gmane/292074, 293236)


* nd/worktree-various-heads (2016-04-22) 13 commits
 - branch: do not rename a branch under bisect or rebase
 - worktree.c: check whether branch is bisected in another worktree
 - wt-status.c: split bisect detection out of wt_status_get_state()
 - worktree.c: check whether branch is rebased in another worktree
 - worktree.c: avoid referencing to worktrees[i] multiple times
 - wt-status.c: make wt_status_check_rebase() work on any worktree
 - wt-status.c: split rebase detection out of wt_status_get_state()
 - path.c: refactor and add worktree_git_path()
 - worktree.c: mark current worktree
 - worktree.c: make find_shared_symref() return struct worktree *
 - worktree.c: store "id" instead of "git_dir"
 - path.c: add git_common_path() and strbuf_git_common_path()
 - dir.c: rename str(n)cmp_icase to fspath(n)cmp

 The experimental "multiple worktree" feature gains more safety to
 forbid operations on a branch that is checked out or being actively
 worked on elsewhere, by noticing that e.g. it is being rebased.

 Being reviewed.
 ($gmane/292189)


* bw/rebase-merge-entire-branch (2016-04-24) 1 commit
  (merged to 'next' on 2016-04-29 at 7a9487f)
 + git-rebase--merge: don't include absent parent as a base

 "git rebase -m" could be asked to rebase an entire branch starting
 from the root, but failed by assuming that there always is a parent
 commit to the first commit on the branch.

 Will merge to 'master'.


* pb/commit-verbose-config (2016-05-02) 7 commits
 - t/t7507: tests for broken behavior of status
 - commit: add a commit.verbose config variable
 - t7507-commit-verbose: improve test coverage by testing number of diffs
 - parse-options.c: make OPTION_COUNTUP respect "unspecified" values
 - t0040-parse-options: improve test coverage
 - test-parse-options: print quiet as integer
 - t0040-test-parse-options.sh: fix style issues

 "git commit" learned to pay attention to "commit.verbose"
 configuration variable and act as if "--verbose" option was
 given from the command line.

 Almost there.
 ($gmane/293410).


* jc/fsck-nul-in-commit (2016-04-14) 2 commits
 - fsck: detect and warn a commit with embedded NUL
 - fsck_commit_buffer(): do not special case the last validation

 "git fsck" learned to catch NUL byte in a commit object as
 potential error and warn.

 What was the status of this one?  Ready to proceed?


* jc/ll-merge-internal (2016-04-27) 3 commits
 - t6036: remove pointless test that expects failure
 - ll-merge: use a longer conflict marker for internal merge
 - ll-merge: fix typo in comment

 "git rerere" can get confused by conflict markers deliberately left
 by the inner merge step, because they are indistinguishable from
 the real conflict markers left by the outermost merge which are
 what the end user and "rerere" need to look at.  This was fixed by
 making the conflict markers left by the inner merges a bit longer.

 Will rebase to remove the comment after three-dash line and then merge.


* jk/diff-compact-heuristic (2016-05-02) 3 commits
  (merged to 'next' on 2016-05-02 at 2a74763)
 + diff: undocument the compaction heuristic knobs for experimentation
  (merged to 'next' on 2016-04-22 at 0c117ea)
 + xdiff: implement empty line chunk heuristic
 + xdiff: add recs_match helper function
 (this branch is tangled with jc/diff-compact-always-use-blank-heuristics.)

 Patch output from "git diff" and friends has been tweaked to be
 more readable by using a blank line as a strong hint that the
 contents before and after it belong to a logically separate unit.

 Will merge to 'master'.


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

 Will cook for a bit more in 'next'.


* jc/send-email-skip-backup (2016-04-12) 1 commit
 - send-email: detect and offer to skip backup files

 A careless invocation of "git send-email directory/" after editing
 0001-change.patch with an editor often ends up sending both
 0001-change.patch and its backup file, 0001-change.patch~, causing
 embarrassment and a minor confusion.  Detect such an input and
 offer to skip the backup files when sending the patches out.

 Needs review.


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
 Does the lack of response mean lack of interest and support?


* jc/drop-git-spec-in (2016-04-27) 2 commits
  (merged to 'next' on 2016-04-27 at 2b85030)
 + Makefile: remove dependency on git.spec
  (merged to 'next' on 2016-04-22 at 531583f)
 + Makefile: stop pretending to support rpmbuild

 As nobody maintains our in-tree git.spec.in and distros use their
 own spec file, we stopped pretending that we support "make rpm".

 Will merge to 'master'.


* kn/ref-filter-branch-list (2016-04-25) 17 commits
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

 Needs review.


* xy/format-patch-base (2016-04-26) 4 commits
 - format-patch: introduce format.useAutoBase configuration
 - format-patch: introduce --base=auto option
 - format-patch: add '--base' option to record base tree info
 - patch-ids: make commit_patch_id() a public helper function

 "git format-patch" learned a new "--base" option to record what
 (public, well-known) commit the original series was built on in
 its output.

 Looking close to be ready.
 ($gmane/292622).


* dt/index-helper (2016-05-02) 19 commits
 . untracked-cache: config option
 . Add tracing to measure where most of the time is spent
 . index-helper: optionally automatically run
 . index-helper: autorun mode
 . index-helper: don't run if already running
 . index-helper: kill mode
 . watchman: add a config option to enable the extension
 . unpack-trees: preserve index extensions
 . update-index: enable/disable watchman support
 . index-helper: use watchman to avoid refreshing index with lstat()
 . watchman: add support to watchman to reduce refresh cost
 . read-cache: add watchman 'WAMA' extension
 . index-helper: add --detach
 . daemonize(): set a flag before exiting the main process
 . index-helper: log warnings
 . index-helper: add --strict
 . index-helper: new daemon for caching index and related stuff
 . read-cache: allow to keep mmap'd memory after reading
 . read-cache.c: fix constness of verify_hdr()

 Needs review.  Reported to break its own tests.
 ($gmane/293461).


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
