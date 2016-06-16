From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2016, #01; Thu, 2)
Date: Thu, 02 Jun 2016 15:52:41 -0700
Message-ID: <xmqqa8j3ryo6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 00:52:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8bTw-0008V3-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 00:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbcFBWws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 18:52:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932166AbcFBWwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 18:52:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC1382059C;
	Thu,  2 Jun 2016 18:52:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=d
	LYd3hB2pSvPwusutjjMB2Kr870=; b=A+dMRQWvy7ptVKaymFt/Cma+ijRoQU7WQ
	cRMazSsn+BhqjQ8G48XlS5GERRRU/4UT6Bb3JMJaonfYbFWlZr9cw+q6OWtajmSW
	jDWVKaIOhvzis6BPyIj94tPOa7JYZQCzpmSjw+DP56C+QvqBiz28G12/MEBDyOvX
	by7a6Py7fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=I0y
	M+qBWcHpRk4UZAQQTNsFB61mjcHxzE1snGE7oobXbLtSSH42AGO8lNt8RnP2uWar
	eDlBt8dMswO7oXs7zm+W9Au6LUVh3C5h3nGX54e0q+iU0vWJ34GBmQrQt5Q15TSf
	1Zno84ghUdbu5+sUvl8uKikU7LTQe97P/aX+AJ90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3CA12059B;
	Thu,  2 Jun 2016 18:52:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E12552059A;
	Thu,  2 Jun 2016 18:52:42 -0400 (EDT)
X-master-at: 60bd4b1c513bb652cdffad44382046ca872140eb
X-next-at: 8a191e187a9dca3d786c0197f9610e627b4f4137
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B718BE6A-2914-11E6-837D-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296251>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

2.9-rc2 is scheduled for early next week.  A handful low-impact
topics are expected to be in 'master' by then.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* et/add-chmod-x (2016-06-01) 2 commits
 - SQUASH??? add: add --chmod=+x / --chmod=-x options
 - add: add --chmod=+x / --chmod=-x options

 Waiting for a reroll (or ack for proposed fixup).


* jc/t2300-setup (2016-06-01) 1 commit
 - t2300: run git-sh-setup in an environment that better mimics the real life

 A test fix.

 Will merge to 'next'.


* jk/shell-portability (2016-06-01) 2 commits
 - t5500 & t7403: lose bash-ism "local"
 - test-lib: add in-shell "env" replacement

 test fixes.

 Will merge to 'next'.


* mh/connect (2016-06-01) 9 commits
 - connect: move ssh command line preparation to a separate function
 - connect: actively reject git:// urls with a user part
 - connect: change the --diag-url output to separate user and host
 - connect: make parse_connect_url() return the user part of the url as a separate value
 - connect: group CONNECT_DIAG_URL handling code
 - connect: make parse_connect_url() return separated host and port
 - connect: re-derive a host:port string from the separate host and port variables
 - connect: call get_host_and_port() earlier
 - connect: document why we sometimes call get_port after get_host_and_port

 Needs review.


* sb/submodule-helper-list-signal-unmatch-via-exit-status (2016-06-01) 1 commit
  (merged to 'next' on 2016-06-02 at 29064a2)
 + submodule--helper: offer a consistent API
 (this branch is used by sb/submodule-helper-relative-path.)

 The way how "submodule--helper list" signals unmatch error to its
 callers has been updated.

 Will merge to 'master'.


* sb/submodule-helper-relative-path (2016-06-01) 1 commit
  (merged to 'next' on 2016-06-02 at 8a191e1)
 + submodule: remove bashism from shell script
 (this branch uses sb/submodule-helper-list-signal-unmatch-via-exit-status.)

 A bash-ism "local" has been removed from "git submodule" scripted
 Porcelain.

 Will merge to 'master'.


* mr/send-email-doc-gmail-2fa (2016-06-01) 1 commit
  (merged to 'next' on 2016-06-02 at cd2ade8)
 + Documentation/git-send-email: fix typo in gmail 2FA section

 Typofix.

 Will merge to 'master'.


* aq/upload-pack-use-parse-options (2016-05-31) 1 commit
 - upload-pack.c: use parse-options API

 "git upload-pack" command has been updated to use the parse-options
 API.

 Will merge to 'next'.


* jc/clear-pathspec (2016-06-02) 1 commit
 - pathspec: rename free_pathspec() to clear_pathspec()

 We usually call a function that clears the contents a data
 structure X without freeing the structure itself clear_X(), and
 call a function that does clear_X() and also frees it free_X().
 free_pathspec() function has been renamed to clear_pathspec()
 to avoid confusion.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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

* js/rebase-i-dedup-call-to-rerere (2016-05-31) 1 commit
  (merged to 'next' on 2016-05-31 at db1f9e3)
 + rebase -i: remove an unnecessary 'rerere' invocation

 "git rebase -i", after it fails to auto-resolve the conflict, had
 an unnecessary call to "git rerere" from its very early days, which
 was spotted recently; the call has been removed.

 Will merge to 'master'.


* sb/submodule-recommend-shallowness (2016-05-27) 2 commits
  (merged to 'next' on 2016-05-31 at 1ee161c)
 + submodule update: learn `--[no-]recommend-shallow` option
 + submodule-config: keep shallow recommendation around

 An upstream project can make a recommendation to make only a
 shallow clone for some submodules in the .gitmodules file it ship.

 Will merge to 'master' after 2.9 final.


* tb/convert-peek-in-index (2016-05-24) 2 commits
 - convert: ce_compare_data() checks for a sha1 of a path
 - read-cache: factor out get_sha1_from_index() helper

 The motivation is rather iffy.


* va/i18n-even-more (2016-05-26) 22 commits
 - t5523: use test_i18ngrep for negation
 - t4153: fix negated test_i18ngrep call
 - t9003: become resilient to GETTEXT_POISON
 - tests: unpack-trees: update to use test_i18n* functions
 - tests: use test_i18n* functions to suppress false positives
 - i18n: setup: mark strings for translation
 - i18n: rebase-interactive: mark comments of squash for translation
 - i18n: rebase-interactive: mark here-doc strings for translation
 - i18n: rebase-interactive: mark strings for translation
 - i18n: git-sh-setup.sh: mark strings for translation
 - t6030: update to use test_i18ncmp
 - i18n: bisect: simplify error message for i18n
 - i18n: rebase: mark placeholder for translation
 - i18n: rebase: fix marked string to use eval_gettext variant
 - merge-octupus: use die shell function from git-sh-setup.sh
 - i18n: merge-octopus: mark messages for translation
 - i18n: sequencer: mark string for translation
 - i18n: sequencer: mark entire sentences for translation
 - i18n: transport: mark strings for translation
 - i18n: advice: internationalize message for conflicts
 - i18n: advice: mark string about detached head for translation
 - i18n: builtin/remote.c: fix mark for translation

 More markings of messages for i18n, with updates to various tests
 to pass GETTEXT_POISON tests.

 Is everybody happy with this version?


* bd/readme.markdown-more (2016-05-31) 1 commit
  (merged to 'next' on 2016-06-02 at 1de7554)
 + README.md: format CLI commands with code syntax

 The mark-up in the top-level README.md file has been updated to
 typeset CLI command names differently from the body text.

 Will merge to 'master'.


* em/man-bold-literal (2016-05-31) 1 commit
  (merged to 'next' on 2016-06-02 at efb4156)
 + Documentation: bold literals in man

 The manpage output of our documentation did not render well in
 terminal; typeset literals in bold by default to make them stand
 out more.

 Will merge to 'master'.


* jg/dash-is-last-branch-in-worktree-add (2016-05-31) 1 commit
  (merged to 'next' on 2016-06-02 at 3959ef6)
 + worktree: allow "-" short-hand for @{-1} in add command

 "git worktree add" learned that '-' can be used as a short-hand for
 "@{-1}", the previous branch.

 Will merge to 'master' after 2.9 final.


* js/perf-rebase-i (2016-05-31) 1 commit
  (merged to 'next' on 2016-05-31 at 39d8dc8)
 + perf: make the tests work without a worktree

 The one in 'master' has a brown-paper-bag bug that breaks the perf
 test when used inside a usual Git repository with a working tree.

 Will merge to 'master'.


* dk/blame-move-no-reason-for-1-line-context (2016-05-29) 1 commit
 - blame: require 0 context lines while finding moved lines with -M

 "git blame -M" missed a single line that was moved within the file.

 We may want to squash a test or two to this commit.  Volunteers?


* mm/makefile-developer-can-be-in-config-mak (2016-06-01) 2 commits
  (merged to 'next' on 2016-06-02 at f3a0678)
 + Makefile: add $(DEVELOPER_CFLAGS) variable
 + Makefile: move 'ifdef DEVELOPER' after config.mak* inclusion

 "make DEVELOPER=1" worked as expected; setting DEVELOPER=1 in
 config.mak didn't.

 Will merge to 'master' after 2.9 final.


* nd/worktree-lock (2016-05-31) 6 commits
 - worktree: add "unlock" command
 - worktree: add "lock" command
 - worktree.c: retrieve lock status (and optionally reason) in get_worktrees()
 - worktree.c: add is_main_worktree()
 - worktree.c: find_worktree() learns to identify worktrees by basename
 - worktree.c: add find_worktree()
 (this branch uses nd/worktree-cleanup-post-head-protection.)

 "git worktree prune" protected worktrees that are marked as
 "locked" by creating a file in a known location.  "git worktree"
 command learned a dedicated command pair to create and remoev such
 a file, so that the users do not have to do this with editor.

 Expecting a reroll.


* pa/cherry-pick-doc-typo (2016-05-29) 1 commit
  (merged to 'next' on 2016-06-02 at e2c2457)
 + git-cherry-pick.txt: correct a small typo

 "git cherry-pick --help" had three instances of word "behavior",
 one of which was spelled "behaviour", which is updated to match the
 other two.

 Will merge to 'master'.


* rs/apply-name-terminate (2016-05-29) 1 commit
  (merged to 'next' on 2016-06-02 at 8df9332)
 + apply: remove unused parameters from name_terminate()

 Code clean-up.

 Will merge to 'master'.


* rs/patch-id-use-skip-prefix (2016-05-29) 1 commit
  (merged to 'next' on 2016-06-02 at c993de3)
 + patch-id: use starts_with() and skip_prefix()

 Code clean-up.

 Will merge to 'master'.


* et/pretty-format-c-auto (2016-05-27) 1 commit
  (merged to 'next' on 2016-05-31 at 1e9c920)
 + format_commit_message: honor `color=auto` for `%C(auto)`

 %C(auto) in a custom format string that commands in `git log`
 family takes unconditionally turned the color on, ignoring
 --no-color or --color=auto with output not connected to a tty;
 this was corrected to make the format truly behave as "auto".

 Will merge to 'master' after 2.9 final.


* ew/daemon-socket-keepalive (2016-05-25) 1 commit
  (merged to 'next' on 2016-05-31 at c32acf1)
 + daemon: enable SO_KEEPALIVE for all sockets

 When "git daemon" is run without --[init-]timeout specified, a
 connection from a client that silently goes offline can hang around
 for a long time, wasting resources.  The socket-level KEEPALIVE has
 been enabled to allow the OS to notice such failed connections.

 Will merge to 'master' after 2.9 final.


* jk/upload-pack-hook (2016-06-02) 7 commits
 - upload-pack: provide a hook for running pack-objects
 - t1308: do not get fooled by symbolic links to the source tree
 - config: add a notion of "scope"
 - config: return configset value for current_config_ functions
 - config: set up config_source for command-line config
 - git_config_parse_parameter: refactor cleanup code
 - git_config_with_options: drop "found" counting

 Allow a custom "git upload-pack" replacement to respond to
 "fetch/clone" request.

 Still under discussion.
 ($gmane/295705).


* rs/xdiff-hunk-with-func-line (2016-05-31) 8 commits
  (merged to 'next' on 2016-06-02 at 0c2e335)
 + grep: -W: don't extend context to trailing empty lines
 + t7810: add test for grep -W and trailing empty context lines
 + xdiff: don't trim common tail with -W
 + xdiff: -W: don't include common trailing empty lines in context
 + xdiff: ignore empty lines before added functions with -W
 + xdiff: handle appended chunks better with -W
 + xdiff: factor out match_func_rec()
 + t4051: rewrite, add more tests

 "git show -W" (extend hunks to cover the entire function, delimited
 by lines that match the "funcname" pattern) used to show the entire
 file when a change added an entire function at the end of the file,
 which has been fixed.

 Will merge to 'master' after 2.9 final.


* sb/submodule-misc-cleanups (2016-05-25) 1 commit
  (merged to 'next' on 2016-05-31 at 0d07b9c)
 + submodule update: make use of the existing fetch_in_submodule function

 Minor simplification.

 Will merge to 'master' after 2.9 final.


* sb/submodule-default-paths (2016-05-26) 7 commits
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - Merge branch 'sb/pathspec-label' into sb/submodule-default-paths
 - Merge branch 'jc/attr' into sb/submodule-default-paths
 - Merge branch 'sb/clone-shallow-passthru' into sb/submodule-default-paths
 - Merge branch 'sb/submodule-deinit-all' into sb/submodule-default-paths
 - Merge branch 'sb/submodule-parallel-update' into sb/submodule-default-paths
 (this branch uses jc/attr and sb/pathspec-label.)

 Will merge to 'next'.


* ah/no-verify-signature-with-pull-rebase (2016-05-20) 1 commit
  (merged to 'next' on 2016-05-31 at 30add83)
 + pull: warn on --verify-signatures with --rebase

 "git pull --rebase --verify-signature" learned to warn the user
 that "--verify-signature" is a no-op.

 Will merge to 'master' after 2.9 final.


* ep/http-curl-trace (2016-05-24) 2 commits
 - imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
 - http.c: implement the GIT_TRACE_CURL environment variable

 HTTP transport gained an option to produce more detailed debugging
 trace.

 Rerolled.  Is everybody happy with this version?


* jc/attr (2016-05-25) 18 commits
  (merged to 'next' on 2016-05-31 at 5b2f08b)
 + attr: support quoting pathname patterns in C style
 + attr: expose validity check for attribute names
 + attr: add counted string version of git_attr()
 + attr: add counted string version of git_check_attr()
 + attr: retire git_check_attrs() API
 + attr: convert git_check_attrs() callers to use the new API
 + attr: convert git_all_attrs() to use "struct git_attr_check"
 + attr: (re)introduce git_check_attr() and struct git_attr_check
 + attr: rename function and struct related to checking attributes
 + attr.c: plug small leak in parse_attr_line()
 + attr.c: tighten constness around "git_attr" structure
 + attr.c: simplify macroexpand_one()
 + attr.c: mark where #if DEBUG ends more clearly
 + attr.c: complete a sentence in a comment
 + attr.c: explain the lack of attr-name syntax check in parse_attr()
 + attr.c: update a stale comment on "struct match_attr"
 + attr.c: use strchrnul() to scan for one line
 + commit.c: use strchrnul() to scan for one line
 (this branch is used by sb/pathspec-label and sb/submodule-default-paths.)

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.


* cc/apply-introduce-state (2016-06-01) 49 commits
 - builtin/apply: move 'newfd' global into 'struct apply_state'
 - builtin/apply: move 'lock_file' global into 'struct apply_state'
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

 Expecting an update.
 ($gmane/296136)


* pb/bisect (2016-05-24) 3 commits
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Beginning of GSoC "git bisect" project.


* sb/pathspec-label (2016-05-25) 4 commits
  (merged to 'next' on 2016-05-31 at e72b604)
 + pathspec: allow querying for attributes
 + pathspec: move prefix check out of the inner loop
 + pathspec: move long magic parsing out of prefix_pathspec
 + Documentation: fix a typo
 (this branch is used by sb/submodule-default-paths; uses jc/attr.)

 The pathspec mechanism learned ":(attr:X)$pattern" pathspec magic
 to limit paths that match $pattern further by attribute settings.

 This breaks anything that uses preload-index with the new pathspec
 magic, because the attribute subsystem is not thread-ready.


* nd/worktree-cleanup-post-head-protection (2016-05-24) 6 commits
 - worktree: simplify prefixing paths
 - worktree: avoid 0{40}, too many zeroes, hard to read
 - worktree.c: use is_dot_or_dotdot()
 - git-worktree.txt: keep subcommand listing in alphabetical order
 - worktree.c: rewrite mark_current_worktree() to avoid strbuf
 - completion: support git-worktree
 (this branch is used by nd/worktree-lock.)

 Further preparatory clean-up for "worktree" feature.

 Expecting a reroll.
 ($gmane/294136, etc.)


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


* ew/fast-import-unpack-limit (2016-05-29) 2 commits
  (merged to 'next' on 2016-05-29 at af32aba)
 + fast-import: invalidate pack_id references after loosening
  (merged to 'next' on 2016-05-11 at ffd4efb)
 + fast-import: implement unpack limit

 "git fast-import" learned the same performance trick to avoid
 creating too small a packfile as "git fetch" and "git push" have,
 using *.unpackLimit configuration.

 Will hold.


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


* dt/index-helper (2016-05-20) 20 commits
 - index-helper: indexhelper.exitafter config
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

 Rerolled.
 ($gmane/295106).


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

* mh/connect-leak (2016-04-28) 1 commit
 . git_connect(): fix memory leak with CONNECT_DIAG_URL

 Is already made obsolete with a patch in flight under discussion.
 ($gmane/292962)
