Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668C81FE4E
	for <e@80x24.org>; Mon, 27 Jun 2016 23:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbcF0XWI (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 19:22:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751974AbcF0XWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 19:22:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D779293BF;
	Mon, 27 Jun 2016 19:22:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=U
	LOggk5s51JdaUNAWW+GpfDcjfI=; b=fDdpjo7At8XvnCXY3LGi8qSwc3lx8MzjQ
	YdJ6wOQ4vbi7BQECUBSiH61vNfnyOMZv4dBZBIfNHl8Q9ML31gPQ/DygJDXDLCuV
	gQIQlfKE8S5yJOi3yjT3KzvCYcFrHQYlu3y9NqzdKlDwxGUd/47tJsKy/IKC0Smm
	j8GdUTYSZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=SZ9
	xxqBH/hR3VDJDNFWAcgu3z119dI0p5InuctJz534t3fCeyhBRh812dLJY/0syBTo
	diyqXcqiKYRgA3ljBRkNxIBEB/K8r/bROYGKTf3cQQjoCQZXc6frtseipn2whXPM
	uLkJUUZbo/8NYDIzFyc/qLW5jzPhGJe4t6pMkMDo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74C33293BE;
	Mon, 27 Jun 2016 19:22:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D9BF293BC;
	Mon, 27 Jun 2016 19:22:01 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2016, #09; Mon, 27)
X-master-at: cf4c2cfe52be5bd973a4838f73a35d3959ce2f43
X-next-at: 760e8615f44f1ce38bfde1e76620c8f8fb1bd5c2
Date:	Mon, 27 Jun 2016 16:21:58 -0700
Message-ID: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F36EF61A-3CBD-11E6-9628-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The first batch for this cycle has been merged to 'master', the tip
of 'next' has been rewound and rebuilt, while a few topics got
temporarily ejected from 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ap/git-svn-propset-doc (2016-06-15) 1 commit
  (merged to 'next' on 2016-06-22 at 5a34f7d)
 + git-svn: document the 'git svn propset' command

 "git svn propset" subcommand that was added in 2.3 days is
 documented now.


* cc/apply-introduce-state (2016-06-06) 50 commits
  (merged to 'next' on 2016-06-20 at 4f205b8)
 + builtin/apply: remove misleading comment on lock_file field
 + builtin/apply: move 'newfd' global into 'struct apply_state'
 + builtin/apply: add 'lock_file' pointer into 'struct apply_state'
 + builtin/apply: move applying patches into apply_all_patches()
 + builtin/apply: move 'state' check into check_apply_state()
 + builtin/apply: move 'symlink_changes' global into 'struct apply_state'
 + builtin/apply: move 'fn_table' global into 'struct apply_state'
 + builtin/apply: move 'state_linenr' global into 'struct apply_state'
 + builtin/apply: move 'max_change' and 'max_len' into 'struct apply_state'
 + builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
 + builtin/apply: move 'ws_error_action' into 'struct apply_state'
 + builtin/apply: move 'applied_after_fixing_ws' into 'struct apply_state'
 + builtin/apply: move 'squelch_whitespace_errors' into 'struct apply_state'
 + builtin/apply: remove whitespace_option arg from set_default_whitespace_mode()
 + builtin/apply: move 'whitespace_option' into 'struct apply_state'
 + builtin/apply: move 'whitespace_error' global into 'struct apply_state'
 + builtin/apply: move 'root' global into 'struct apply_state'
 + builtin/apply: move 'p_value_known' global into 'struct apply_state'
 + builtin/apply: move 'p_value' global into 'struct apply_state'
 + builtin/apply: move 'has_include' global into 'struct apply_state'
 + builtin/apply: move 'limit_by_name' global into 'struct apply_state'
 + builtin/apply: move 'patch_input_file' global into 'struct apply_state'
 + builtin/apply: move 'apply' global into 'struct apply_state'
 + builtin/apply: move 'p_context' global into 'struct apply_state'
 + builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
 + builtin/apply: move 'line_termination' global into 'struct apply_state'
 + builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
 + builtin/apply: move 'no_add' global into 'struct apply_state'
 + builtin/apply: move 'threeway' global into 'struct apply_state'
 + builtin/apply: move 'summary' global into 'struct apply_state'
 + builtin/apply: move 'numstat' global into 'struct apply_state'
 + builtin/apply: move 'diffstat' global into 'struct apply_state'
 + builtin/apply: move 'cached' global into 'struct apply_state'
 + builtin/apply: move 'allow_overlap' global into 'struct apply_state'
 + builtin/apply: move 'update_index' global into 'struct apply_state'
 + builtin/apply: move 'apply_verbosely' global into 'struct apply_state'
 + builtin/apply: move 'apply_with_reject' global into 'struct apply_state'
 + builtin/apply: move 'apply_in_reverse' global into 'struct apply_state'
 + builtin/apply: move 'check_index' global into 'struct apply_state'
 + builtin/apply: move 'check' global into 'struct apply_state'
 + builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
 + builtin/apply: move 'state' init into init_apply_state()
 + builtin/apply: introduce 'struct apply_state' to start libifying
 + builtin/apply: move 'read_stdin' global into cmd_apply()
 + builtin/apply: move 'options' variable into cmd_apply()
 + builtin/apply: extract line_by_line_fuzzy_match() from match_fragment()
 + builtin/apply: avoid local variable shadowing 'len' parameter
 + builtin/apply: avoid parameter shadowing 'linenr' global
 + builtin/apply: avoid parameter shadowing 'p_value' global
 + builtin/apply: make gitdiff_verify_name() return void

 Originally merged to 'next' on 2016-06-06

 The "git apply" standalone program is being libified; this is the
 first step to move many state variables into a structure that can
 be explicitly (re)initialized to make the machinery callable more
 than once.

 The next step that moves some remaining state variables into the
 structure and turns die()s into an error return that propagates up
 to the caller is not queued yet but in flight.  It would be good to
 review the above first and give the remainder of the series a solid
 base to build on.


* dn/gpg-doc (2016-06-16) 1 commit
  (merged to 'next' on 2016-06-22 at f467355)
 + Documentation: GPG capitalization

 The documentation tries to consistently spell "GPG"; when
 referring to the specific program name, "gpg" is used.


* em/newer-freebsd-shells-are-fine-with-returns (2016-06-17) 1 commit
  (merged to 'next' on 2016-06-22 at dbee33c)
 + rebase: update comment about FreeBSD /bin/sh

 Comments about misbehaving FreeBSD shells have been clarified with
 the version number (9.x and before are broken, newer ones are OK).


* et/add-chmod-x (2016-06-07) 1 commit
  (merged to 'next' on 2016-06-22 at 71d65a0)
 + add: add --chmod=+x / --chmod=-x options

 "git update-index --add --chmod=+x file" may be usable as an escape
 hatch, but not a friendly thing to force for people who do need to
 use it regularly.  "git add --chmod=+x file" can be used instead.


* jc/deref-tag (2016-06-14) 1 commit
  (merged to 'next' on 2016-06-22 at 1075713)
 + blame, line-log: do not loop around deref_tag()

 Code clean-up.


* jk/avoid-unbounded-alloca (2016-06-07) 1 commit
  (merged to 'next' on 2016-06-22 at 93feb23)
 + tree-diff: avoid alloca for large allocations

 A codepath that used alloca(3) to place an unbounded amount of data
 on the stack has been updated to avoid doing so.


* jk/fetch-prune-doc (2016-06-14) 1 commit
  (merged to 'next' on 2016-06-22 at 6563376)
 + fetch: document that pruning happens before fetching

 Minor doc update.


* lf/receive-pack-auto-gc-to-client (2016-06-06) 1 commit
  (merged to 'next' on 2016-06-22 at 92162f5)
 + receive-pack: send auto-gc output over sideband 2

 Messages that are generated by auto gc during "git push" on the
 receiving end are now passed back to the sending end in such a way
 that they are shown with "remote: " prefix to avoid confusing the
 users.


* lv/status-say-working-tree-not-directory (2016-06-09) 1 commit
  (merged to 'next' on 2016-06-22 at c65c7c1)
 + Use "working tree" instead of "working directory" for git status

 "git status" used to say "working directory" when it meant "working
 tree".


* mg/cherry-pick-multi-on-unborn (2016-06-06) 1 commit
  (merged to 'next' on 2016-06-22 at 183295b)
 + cherry-pick: allow to pick to unborn branches

 "git cherry-pick A" worked on an unborn branch, but "git
 cherry-pick A..B" didn't.


* nb/gnome-keyring-build (2016-06-14) 1 commit
  (merged to 'next' on 2016-06-22 at 0dfb90c)
 + gnome-keyring: Don't hard-code pkg-config executable

 Build improvements for gnome-keyring (in contrib/)


* pb/strbuf-read-file-doc (2016-06-14) 1 commit
  (merged to 'next' on 2016-06-22 at 10e4b4f)
 + strbuf: describe the return value of strbuf_read_file

 Minor doc update.


* pc/occurred (2016-06-10) 2 commits
  (merged to 'next' on 2016-06-22 at ce0b944)
 + config.c: fix misspelt "occurred" in an error message
 + refs.h: fix misspelt "occurred" in a comment

 Typofix.


* rj/compat-regex-size-max-fix (2016-06-06) 1 commit
  (merged to 'next' on 2016-06-22 at 376c5b1)
 + regex: fix a SIZE_MAX macro redefinition warning

 A compilation fix.


* sg/reflog-past-root (2016-06-06) 1 commit
  (merged to 'next' on 2016-06-22 at c5d4e29)
 + reflog: continue walking the reflog past root commits

 "git reflog" stopped upon seeing an entry that denotes a branch
 creation event (aka "unborn"), which made it appear as if the
 reflog was truncated.


* tb/complete-status (2016-06-10) 3 commits
  (merged to 'next' on 2016-06-22 at 44ae68f)
 + completion: add git status
 + completion: add __git_get_option_value helper
 + completion: factor out untracked file modes into a variable

 The completion script (in contrib/) learned to complete "git
 status" options.


* tr/doc-tt (2016-06-08) 4 commits
  (merged to 'next' on 2016-06-22 at dc6df3b)
 + doc: change configuration variables format
 + doc: more consistency in environment variables format
 + doc: change environment variables format
 + doc: clearer rule about formatting literals

 The documentation set has been updated so that literal commands,
 configuration variables and environment variables are consistently
 typeset in fixed-width font and bold in manpages.


* vs/prompt-avoid-unset-variable (2016-06-06) 1 commit
  (merged to 'next' on 2016-06-22 at 8bf21d3)
 + git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION, $short_sha

 The git-prompt scriptlet (in contrib/) was not friendly with those
 who uses "set -u", which has been fixed.

--------------------------------------------------
[New Topics]

* jk/test-match-signal (2016-06-24) 4 commits
 - t/lib-git-daemon: use test_match_signal
 - test_must_fail: use test_match_signal
 - t0005: use test_match_signal as appropriate
 - tests: factor portable signal check out of t0005

 The test framework learned a new helper test_match_signal to check
 an exit code from getting killed by an expected signal.

 Will merge to 'next'.


* ah/unpack-trees-advice-messages (2016-06-27) 1 commit
 - unpack-trees: fix English grammar in do-this-before-that messages

 Will merge to 'next'.


* ew/gc-auto-pack-limit-fix (2016-06-27) 1 commit
 - gc: fix off-by-one error with gc.autoPackLimit

 "gc.autoPackLimit" when set to 1 should not trigger a repacking
 when there is only one pack, but the code counted poorly and did
 so.

 Will merge to 'next'.


* nd/connect-ssh-command-config (2016-06-27) 1 commit
 - connect: read $GIT_SSH_COMMAND from config file

 A new configuration variable core.sshCommand to specify what value
 for GIT_SSH_COMMAND to use per repository.


* nd/doc-new-command (2016-06-27) 1 commit
 - new-command.txt: correct the command description file

 Will merge to 'next'.


* po/range-doc (2016-06-27) 3 commits
 - doc: give headings for the two and three dot notations
 - doc: show the actual left, right, and boundary marks
 - doc: use 'symmetric difference' consistently


* sb/submodule-parallel-fetch (2016-06-27) 2 commits
 - xwrite: poll on non-blocking FDs
 - xread: retry after poll on EAGAIN/EWOULDBLOCK

 Fix a recently introduced codepaths that are involved in parallel
 submodule operations, which gave up on reading too early, and
 could have wasted CPU while attempting to write under a corner case
 condition.

 Will merge to 'next'.


* mm/doc-tt (2016-06-27) 6 commits
 - doc: typeset HEAD and variants as litteral
 - CodingGuidelines: formatting HEAD in documentation
 - doc: typeset long options with argument as litteral
 - doc: typeset -- as litteral
 - doc: typeset long command-line options as literal
 - doc: typeset short command-line options as literal

 More mark-up updates to typeset strings that are expected to
 literally typed by the end user in fixed-width font.


* nd/fetch-ref-summary (2016-06-27) 5 commits
 - fetch: reduce duplicate in ref update status lines with placeholder
 - fetch: align all "remote -> local" output
 - fetch: change flag code for displaying tag update and deleted ref
 - fetch: refactor ref update status formatting code
 - git-fetch.txt: document fetch output

 Improve the look of the way "git fetch" reports what happened to
 each ref that was fetched.

 Still being discussed.

--------------------------------------------------
[Stalled]

* tb/convert-peek-in-index (2016-06-07) 3 commits
 - correct ce_compare_data() in a middle of a merge
 - read-cache: factor out get_sha1_from_index() helper
 - convert: unify the "auto" handling of CRLF
 (this branch is used by jh/clean-smudge-annex.)

 Needs review.


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

* ak/t7800-wo-readlink (2016-06-21) 1 commit
 - t7800: readlink may not be available

 One among four invocations of readlink(1) in our test suite has
 been rewritten so that the test can run on systems without the
 command (others are in valgrind test framework and t9802).

 Will merge to 'next'.


* js/perf-on-apple (2016-06-21) 1 commit
 - perf: accommodate for MacOSX

 t/perf needs /usr/bin/time with GNU extension; the invocation of it
 is updated to "gtime" on Darwin.

 Will merge to 'next'.


* sb/t5614-modernize (2016-06-21) 1 commit
 - t5614: don't use subshells
 (this branch uses sb/clone-shallow-passthru.)

 Test clean-up.

 Will merge to 'next'.


* ao/p4-has-branch-prefix-fix (2016-06-22) 1 commit
 - git-p4: correct hasBranchPrefix verbose output

 A bug, which caused "git p4" while running under verbose mode to
 report paths that are omitted due to branch prefix incorrectly, has
 been fixed; the command said "Ignoring file outside of prefix" for
 paths that are _inside_.

 Will merge to 'next'.


* cb/t7810-test-label-fix (2016-06-21) 1 commit
 - t7810: fix duplicated test title

 Test clean-up.

 Will merge to 'next'.


* jc/t2300-setup (2016-06-22) 1 commit
 - t2300: "git --exec-path" is not usable in $PATH on Windows as-is

 Portability fix for Windows.

 Will merge to 'next'.


* jk/perf-any-version (2016-06-22) 2 commits
 - p4211: explicitly disable renames in no-rename test
 - t/perf: fix regression in testing older versions of git

 Allow t/perf framework to use the features from the most recent
 version of Git even when testing an older installed version.

 Will merge to 'next'.


* jn/preformatted-doc-url (2016-06-22) 1 commit
 - doc: git-htmldocs.googlecode.com is no more

 Will merge to 'next'.


* ex/deprecate-empty-pathspec-as-match-all (2016-06-22) 1 commit
 - pathspec: warn on empty strings as pathspec

 An empty string used as a pathspec element has always meant
 'everything matches', but it is too easy to write a script that
 finds a path to remove in $path and run 'git rm "$paht"', which
 ends up removing everything.  Start warning about this use of an
 empty string used for 'everything matches' and ask users to use a
 more explicit '.' for that instead.

 The hope is that existing users will not mind this change, and
 eventually the warning can be turned into a hard error, upgrading
 the deprecation into removal of this (mis)feature.

 Will wait for further comments for a bit before merging to 'next'.


* jk/ansi-color (2016-06-23) 7 commits
 - color: support strike-through attribute
 - color: support "italic" attribute
 - color: allow "no-" for negating attributes
 - color: refactor parse_attr
 - add skip_prefix_mem helper
 - doc: refactor description of color format
 - color: fix max-size comment

 The output coloring scheme learned two new attributes, italic and
 strike, in addition to existing bold, reverse, etc.

 Will merge to 'next'.


* nd/icase (2016-06-27) 13 commits
 - SQUASH???
 - grep.c: reuse "icase" variable
 - diffcore-pickaxe: support case insensitive match on non-ascii
 - diffcore-pickaxe: Add regcomp_or_die()
 - grep/pcre: support utf-8
 - gettext: add is_utf8_locale()
 - grep/pcre: prepare locale-dependent tables for icase matching
 - grep: rewrite an if/else condition to avoid duplicate expression
 - grep/icase: avoid kwsset when -F is specified
 - grep/icase: avoid kwsset on literal non-ascii strings
 - test-regex: expose full regcomp() to the command line
 - test-regex: isolate the bug test code
 - grep: break down an "if" stmt in preparation for next changes

 "git grep -i" has been taught to fold case in non-ascii locales
 correctly.

 Modulo minor possible nits, this round looked mostly sensible.


* mj/log-show-signature-conf (2016-06-24) 3 commits
 - log: add log.showSignature configuration variable
 - log: add "--no-show-signature" command line option
 - t4202: refactor test

 "git log" learns log.showSignature configuration variable, and a
 command line option "--no-show-signature" to countermand it.

 Will merge to 'next'.


* mg/signature-doc (2016-06-17) 4 commits
 - Documentation/technical: signed merge tag format
 - Documentation/technical: signed commit format
 - Documentation/technical: signed tag format
 - Documentation/technical: describe signature formats

 Formats of the various data (and how to validate them) where we use
 GPG signature have been documented.

 Will merge to 'next'.


* jk/string-list-static-init (2016-06-13) 2 commits
  (merged to 'next' on 2016-06-27 at 3d4b2fa)
 + use string_list initializer consistently
 + Merge branch 'jk/parseopt-string-list' into jk/string-list-static-init
 (this branch uses jk/parseopt-string-list.)

 Instead of taking advantage of a struct string_list that is
 allocated with all NULs happens to be STRING_LIST_INIT_NODUP kind,
 initialize them explicitly as such, to document their behaviour
 better.

 Will merge to 'master'.


* mh/ref-store (2016-06-20) 38 commits
 - refs: implement iteration over only per-worktree refs
 - refs: make lock generic
 - refs: add method to rename refs
 - refs: add methods to init refs db
 - refs: make delete_refs() virtual
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add method iterator_begin
 - files_ref_iterator_begin(): take a ref_store argument
 - split_symref_update(): add a files_ref_store argument
 - lock_ref_sha1_basic(): add a files_ref_store argument
 - lock_ref_for_update(): add a files_ref_store argument
 - commit_ref_update(): add a files_ref_store argument
 - lock_raw_ref(): add a files_ref_store argument
 - repack_without_refs(): add a files_ref_store argument
 - refs: make peel_ref() virtual
 - refs: make create_symref() virtual
 - refs: make pack_refs() virtual
 - refs: make verify_refname_available() virtual
 - refs: make read_raw_ref() virtual
 - resolve_gitlink_ref(): rename path parameter to submodule
 - resolve_gitlink_ref(): avoid memory allocation in many cases
 - resolve_gitlink_ref(): implement using resolve_ref_recursively()
 - resolve_ref_recursively(): new function
 - read_raw_ref(): take a (struct ref_store *) argument
 - resolve_gitlink_packed_ref(): remove function
 - resolve_packed_ref(): rename function from resolve_missing_loose_ref()
 - refs: reorder definitions
 - refs: add a transaction_commit() method
 - {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
 - resolve_missing_loose_ref(): add a files_ref_store argument
 - get_packed_ref(): add a files_ref_store argument
 - add_packed_ref(): add a files_ref_store argument
 - refs: create a base class "ref_store" for files_ref_store
 - refs: add a backend method structure
 - refs: rename struct ref_cache to files_ref_store
 - rename_ref_available(): add docstring
 - resolve_gitlink_ref(): eliminate temporary variable
 (this branch uses mh/ref-iterators and mh/split-under-lock; is tangled with mh/update-ref-errors.)

 The ref-store abstraction was introduced to the refs API so that we
 can plug in different backends to store references.

 Rebased on top of mh/split-under-lock.


* mh/update-ref-errors (2016-06-20) 6 commits
 - lock_ref_for_update(): avoid a symref resolution
 - lock_ref_for_update(): make error handling more uniform
 - t1404: add more tests of update-ref error handling
 - t1404: document function test_update_rejected
 - t1404: remove "prefix" argument to test_update_rejected
 - t1404: rename file to t1404-update-ref-errors.sh
 (this branch uses mh/split-under-lock; is tangled with mh/ref-iterators and mh/ref-store.)

 Error handling in the codepaths that updates refs has been
 improved.

 Rebased on top of mh/split-under-lock.


* jh/clean-smudge-annex (2016-06-22) 10 commits
 - SQUASH???
 - use smudgeToFile filter in recursive merge
 - use smudgeToFile filter in git am
 - better recovery from failure of smudgeToFile filter
 - warn on unusable smudgeToFile/cleanFromFile config
 - use smudgeToFile in git checkout etc
 - use cleanFromFile in git add
 - add smudgeToFile and cleanFromFile filter configs
 - clarify %f documentation
 - Merge branch 'tb/convert-peek-in-index' into jh/clean-smudge-annex
 (this branch uses tb/convert-peek-in-index.)

 The interface to "clean/smudge" filters require Git to feed the
 whole contents via pipe, which is suboptimal for some
 applications.  "cleanFromFile/smudgeToFile" commands are the moral
 equilvalents for these filters but they interact with the files on
 the filesystem directly.


* lc/shell-default-value-noexpand (2016-06-19) 1 commit
 - sh-setup: enclose setting of ${VAR=default} in double-quotes

 Fix unnecessarily waste in the idiomatic use of ': ${VAR=default}'
 to set the default value, without enclosing it in double quotes.

 Will merge to 'next'.


* sb/clone-shallow-passthru (2016-06-20) 1 commit
 - clone: do not let --depth imply --shallow-submodules
 (this branch is used by sb/t5614-modernize.)

 Fix an unintended regression in v2.9 that breaks "clone --depth"
 that recurses down to submodules by forcing the submodules to also
 be cloned shallowly, which many server instances that host upstream
 of the submodules are not prepared for.

 Will merge to 'next'.


* js/find-commit-subject-ignore-leading-blanks (2016-06-22) 2 commits
 - commit.c: make find_commit_subject() more robust
 - pretty: make the skip_blank_lines() function public

 A helper function that takes the contents of a commit object and
 finds its subject line did not ignore leading blank lines, as is
 commonly done by other codepaths.  Make it ignore leading blank
 lines to match.

 Will merge to 'next'.


* js/log-to-diffopt-file (2016-06-24) 10 commits
 - t4211: ensure that log respects --output=<file>
 - shortlog: respect the --output=<file> setting
 - format-patch: use stdout directly
 - format-patch: avoid freopen()
 - format-patch: explicitly switch off color when writing to files
 - shortlog: support outputting to streams other than stdout
 - graph: respect the diffopt.file setting
 - line-log: respect diffopt's configured output file stream
 - log-tree: respect diffopt's configured output file stream
 - log: prepare log/log-tree to reuse the diffopt.close_file attribute

 The commands in the "log/diff" family had an FILE* pointer in the
 data structure they pass around for a long time, but some codepaths
 used to always write to the standard output.  As a preparatory step
 to make "git format-patch" available to the internal callers, these
 codepaths have been updated to consistently write into that FILE*
 instead.


* js/mingw-parameter-less-c-functions (2016-06-20) 1 commit
 - mingw: let the build succeed with DEVELOPER=1

 Some platform-specific code had non-ANSI strict declarations of C
 functions that do not take any parameters, which has been
 corrected.

 Will merge to 'next'.


* bc/cocci (2016-06-20) 8 commits
 - merge-recursive: convert merge_recursive_generic to object_id
 - merge-recursive: convert leaf functions to use struct object_id
 - merge-recursive: convert struct merge_file_info to object_id
 - merge-recursive: convert struct stage_data to use object_id
 - diff: rename struct diff_filespec's sha1_valid member
 - diff: convert struct diff_filespec to struct object_id
 - coccinelle: apply object_id Coccinelle transformations
 - contrib/coccinelle: add basic Coccinelle transforms

 Conversion from unsigned char sha1[20] to struct object_id
 continues.


* jk/tzoffset-fix (2016-06-20) 3 commits
 - local_tzoffset: detect errors from tm_to_time_t
 - t0006: test various date formats
 - t0006: rename test-date's "show" to "relative"

 The internal code used to show local timezone offset is not
 prepared to handle timestamps beyond year 2100, and gave a
 bogus offset value to the caller.  Use a more benign looking
 +0000 instead and let "git log" going in such a case, instead
 of aborting.

 Will merge to 'next'.


* jk/add-i-diff-compact-heuristics (2016-06-16) 1 commit
  (merged to 'next' on 2016-06-27 at 568f892)
 + add--interactive: respect diff.compactionHeuristic

 "git add -i/-p" learned to honor diff.compactionHeuristic
 experimental knob, so that the user can work on the same hunk split
 as "git diff" output.

 Will merge to 'master'.


* jk/big-and-future-archive-tar (2016-06-21) 2 commits
 - archive-tar: write extended headers for far-future mtime
 - archive-tar: write extended headers for file sizes >= 8GB

 "git archive" learned to handle files that are larger than 8GB and
 commits far in the future than expressible by the traditional US-TAR
 format.

 Expecting a reroll.
 ($gmane/298119)


* jk/gpg-interface-cleanup (2016-06-17) 7 commits
 - gpg-interface: check gpg signature creation status
 - sign_buffer: use pipe_command
 - verify_signed_buffer: use pipe_command
 - run-command: add pipe_command helper
 - verify_signed_buffer: use tempfile object
 - verify_signed_buffer: drop pbuf variable
 - gpg-interface: use child_process.args

 A new run-command API function pipe_command() is introduced to
 sanely feed data to the standard input while capturing data from
 the standard output and the standard error of an external process,
 which is cumbersome to hand-roll correctly without deadlocking.

 The codepath to sign data in a prepared buffer with GPG has been
 updated to use this API to read from the status-fd to check for
 errors (instead of relying on GPG's exit status).

 Will merge to 'next'.


* lf/sideband-returns-void (2016-06-16) 2 commits
  (merged to 'next' on 2016-06-27 at 558c781)
 + upload-pack.c: make send_client_data() return void
 + sideband.c: make send_sideband() return void

 A small internal API cleanup.

 Will merge to 'master'.


* nd/graph-width-padded (2016-06-16) 2 commits
 - pretty.c: support <direction>|(<negative number>) forms
 - pretty: pass graph width to pretty formatting for use in '%>|(N)'

 "log --graph --format=" learned that "%>|(N)" specifies the width
 relative to the terminal's left edge, not relative to the area to
 draw text that is to the right of the ancestry-graph section.  It
 also now accepts negative N that means the column limit is relative
 to the right border.

 Will merge to 'next'.


* jk/bisect-show-tree (2016-06-16) 1 commit
  (merged to 'next' on 2016-06-27 at 6970f87e)
 + bisect: always call setup_revisions after init_revisions

 "git bisect" makes an internal call to "git diff-tree" when
 bisection finds the culprit, but this call did not initialize the
 data structure to pass to the diff-tree API correctly.

 Will merge to 'master'.


* jk/parseopt-string-list (2016-06-13) 3 commits
  (merged to 'next' on 2016-06-27 at 27462e6)
 + blame,shortlog: don't make local option variables static
 + interpret-trailers: don't duplicate option strings
 + parse_opt_string_list: stop allocating new strings
 (this branch is used by jk/string-list-static-init.)

 The command line argument parsing that uses OPT_STRING_LIST() often
 made a copy of the argv[] element, which was unnecessary.

 Will merge to 'master'.


* jk/repack-keep-unreachable (2016-06-14) 3 commits
 - repack: extend --keep-unreachable to loose objects
 - repack: add --keep-unreachable option
 - repack: document --unpack-unreachable option

 "git repack" learned the "--keep-unreachable" option, which sends
 loose unreachable objects to a pack instead of leaving them loose.
 This helps heuristics based on the number of loose objects
 (e.g. "gc --auto").

 Will merge to 'next'.


* lf/recv-sideband-cleanup (2016-06-13) 1 commit
 - sideband.c: refactor recv_sideband()

 Code simplification.  It however loses the atomicity of the output
 9ac13ec9 (atomic write for sideband remote messages, 2006-10-11)
 tried to add to an once-much-simpler codebase.

 Expecting a reroll.


* nd/test-lib-httpd-show-error-log-in-verbose (2016-06-13) 1 commit
  (merged to 'next' on 2016-06-27 at 9793d81)
 + lib-httpd.sh: print error.log on error

 Debugging aid.

 Will merge to 'master'.


* sb/submodule-clone-retry (2016-06-13) 2 commits
 - submodule update: continue when a clone fails
 - submodule--helper: initial clone learns retry logic

 "git submodule update" that drives many "git clone" could
 eventually hit flaky servers/network conditions on one of the
 submodules; the command learned to retry the attempt.

 Will merge to 'next'.


* jc/blame-reverse (2016-06-14) 2 commits
 - blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
 - blame: improve diagnosis for "--reverse NEW"

 It is a common mistake to say "git blame --reverse OLD path",
 expecting that the command line is dwimmed as if asking how lines
 in path in an old revision OLD have survived up to the current
 commit.

 Any supporters?  Otherwise will drop.


* km/fetch-do-not-free-remote-name (2016-06-14) 1 commit
  (merged to 'next' on 2016-06-27 at 4bc34c4)
 + builtin/fetch.c: don't free remote->name after fetch

 The ownership rule for the piece of memory that hold references to
 be fetched in "git fetch" was screwy, which has been cleaned up.

 Will merge to 'master'.


* nd/shallow-deepen (2016-06-13) 27 commits
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
 - upload-pack: make check_non_tip() clean things up on error
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

 Rerolled.
 Needs review.  What this topic attempts to achieve is worthwhile, I
 would think.


* jk/send-pack-stdio (2016-06-10) 2 commits
  (merged to 'next' on 2016-06-27 at 2cfb0ff)
 + write_or_die: remove the unused write_or_whine() function
 + send-pack: use buffered I/O to talk to pack-objects

 Code clean-up.

 Will merge to 'master'.


* pb/commit-editmsg-path (2016-06-09) 1 commit
  (merged to 'next' on 2016-06-27 at 0f01ce1)
 + builtin/commit.c: memoize git-path for COMMIT_EDITMSG

 Code clean-up.

 Will merge to 'master'.


* jc/attr-more (2016-06-09) 8 commits
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - fixup! d5ad6c13
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 (this branch uses jc/attr; is tangled with sb/pathspec-label and sb/submodule-default-paths.)

 The beginning of long and tortuous journey to clean-up attribute
 subsystem implementation.

 Needs to be redone.


* mh/ref-iterators (2016-06-20) 13 commits
 - for_each_reflog(): reimplement using iterators
 - dir_iterator: new API for iterating over a directory tree
 - for_each_reflog(): don't abort for bad references
 - do_for_each_ref(): reimplement using reference iteration
 - refs: introduce an iterator interface
 - ref_resolves_to_object(): new function
 - entry_resolves_to_object(): rename function from ref_resolves_to_object()
 - get_ref_cache(): only create an instance if there is a submodule
 - remote rm: handle symbolic refs correctly
 - delete_refs(): add a flags argument
 - refs: use name "prefix" consistently
 - do_for_each_ref(): move docstring to the header file
 - refs: remove unnecessary "extern" keywords
 (this branch is used by mh/ref-store; uses mh/split-under-lock; is tangled with mh/update-ref-errors.)

 The API to iterate over all the refs (i.e. for_each_ref(), etc.)
 has been revamped.

 Rebased on top of mh/split-under-lock.


* ew/mboxrd-format-am (2016-06-06) 3 commits
 - am: support --patch-format=mboxrd
 - mailsplit: support unescaping mboxrd messages
 - pretty: support "mboxrd" output format

 Teach format-patch and mailsplit (hence "am") how a line that
 happens to begin with "From " in the e-mail message is quoted with
 ">", so that these lines can be restored to their original shape.

 Will merge to 'next'.


* mh/connect (2016-06-06) 10 commits
 - connect: [host:port] is legacy for ssh
 - connect: move ssh command line preparation to a separate function
 - connect: actively reject git:// urls with a user part
 - connect: change the --diag-url output to separate user and host
 - connect: make parse_connect_url() return the user part of the url as a separate value
 - connect: group CONNECT_DIAG_URL handling code
 - connect: make parse_connect_url() return separated host and port
 - connect: re-derive a host:port string from the separate host and port variables
 - connect: call get_host_and_port() earlier
 - connect: document why we sometimes call get_port after get_host_and_port

 Rewrite Git-URL parsing routine (hopefully) without changing any
 behaviour.


* va/i18n-even-more (2016-06-17) 38 commits
 - i18n: branch: mark comment when editing branch description for translation
 - i18n: unmark die messages for translation
 - i18n: submodule: escape shell variables inside eval_gettext
 - i18n: submodule: join strings marked for translation
 - i18n: init-db: join message pieces
 - i18n: remote: allow translations to reorder message
 - i18n: remote: mark URL fallback text for translation
 - i18n: standardise messages
 - i18n: sequencer: add period to error message
 - i18n: merge: change command option help to lowercase
 - i18n: merge: mark messages for translation
 - i18n: notes: mark options for translation
 - i18n: notes: mark strings for translation
 - i18n: transport-helper.c: change N_() call to _()
 - i18n: bisect: mark strings for translation
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
 - merge-octopus: use die shell function from git-sh-setup.sh
 - i18n: merge-octopus: mark messages for translation
 - i18n: sequencer: mark string for translation
 - i18n: sequencer: mark entire sentences for translation
 - i18n: transport: mark strings for translation
 - i18n: advice: internationalize message for conflicts
 - i18n: advice: mark string about detached head for translation
 - i18n: builtin/remote.c: fix mark for translation
 - Merge branch 'jc/t2300-setup' into HEAD

 More markings of messages for i18n, with updates to various tests
 to pass GETTEXT_POISON tests.

 One patch from the original submission dropped due to conflicts
 with jk/upload-pack-hook, which is still in flux.

 Will merge to 'next'.


* dk/blame-move-no-reason-for-1-line-context (2016-05-29) 1 commit
 - blame: require 0 context lines while finding moved lines with -M

 "git blame -M" missed a single line that was moved within the file.

 We may want to squash a test or two to this commit.  Volunteers?


* nd/worktree-lock (2016-06-13) 6 commits
 - worktree.c: find_worktree() search by path suffix
 - worktree: add "unlock" command
 - worktree: add "lock" command
 - worktree.c: add is_worktree_locked()
 - worktree.c: add is_main_worktree()
 - worktree.c: add find_worktree()
 (this branch uses nd/worktree-cleanup-post-head-protection.)

 "git worktree prune" protected worktrees that are marked as
 "locked" by creating a file in a known location.  "git worktree"
 command learned a dedicated command pair to create and remoev such
 a file, so that the users do not have to do this with editor.

 Is everybody happy with this version?
 If so, will merge to 'next'.


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

 Will merge to 'next'.


* sb/submodule-default-paths (2016-06-20) 5 commits
 - completion: clone can recurse into submodules
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - Merge branch 'sb/pathspec-label' into sb/submodule-default-paths
 - Merge branch 'jc/attr' into sb/submodule-default-paths
 (this branch uses jc/attr and sb/pathspec-label; is tangled with jc/attr-more.)

 Allow specifying the set of submodules the user is interested in on
 the command line of "git clone" that clones the superproject.


* ep/http-curl-trace (2016-05-24) 2 commits
  (merged to 'next' on 2016-06-27 at c290515)
 + imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
 + http.c: implement the GIT_TRACE_CURL environment variable

 HTTP transport gained an option to produce more detailed debugging
 trace.

 Will merge to 'master'.


* jc/attr (2016-05-25) 18 commits
 - attr: support quoting pathname patterns in C style
 - attr: expose validity check for attribute names
 - attr: add counted string version of git_attr()
 - attr: add counted string version of git_check_attr()
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct git_attr_check"
 - attr: (re)introduce git_check_attr() and struct git_attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line
 (this branch is used by jc/attr-more, sb/pathspec-label and sb/submodule-default-paths.)

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.

 I wanted to polish this topic further to make the attribute
 subsystem thread-ready, but because other topics depend on this
 topic and they do not (yet) need it to be thread-ready, let's merge
 this early part together with the dependent topics to 'next', and
 back-burner the threading enhancement to another day.


* pb/bisect (2016-06-27) 9 commits
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 GSoC "bisect" topic.


* sb/pathspec-label (2016-06-03) 6 commits
 - pathspec: disable preload-index when attribute pathspec magic is in use
 - pathspec: allow escaped query values
 - pathspec: allow querying for attributes
 - pathspec: move prefix check out of the inner loop
 - pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 (this branch is used by sb/submodule-default-paths; uses jc/attr; is tangled with jc/attr-more.)

 The pathspec mechanism learned ":(attr:X)$pattern" pathspec magic
 to limit paths that match $pattern further by attribute settings.
 The preload-index mechanism is disabled when the new pathspec magic
 is in use (at least for now), because the attribute subsystem is
 not thread-ready.


* nd/worktree-cleanup-post-head-protection (2016-05-24) 6 commits
 - worktree: simplify prefixing paths
 - worktree: avoid 0{40}, too many zeroes, hard to read
 - worktree.c: use is_dot_or_dotdot()
 - git-worktree.txt: keep subcommand listing in alphabetical order
 - worktree.c: rewrite mark_current_worktree() to avoid strbuf
 - completion: support git-worktree
 (this branch is used by nd/worktree-lock.)

 Further preparatory clean-up for "worktree" feature.

 Will merge to 'next'.


* mh/split-under-lock (2016-06-13) 33 commits
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
 - ref_transaction_commit(): remove local variables n and updates
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
 (this branch is used by mh/ref-iterators, mh/ref-store and mh/update-ref-errors.)

 Further preparatory work on the refs API before the pluggable
 backend series can land.

 Replaced with a rerolled version.


* jc/send-email-skip-backup (2016-04-12) 1 commit
 - send-email: detect and offer to skip backup files

 A careless invocation of "git send-email directory/" after editing
 0001-change.patch with an editor often ends up sending both
 0001-change.patch and its backup file, 0001-change.patch~, causing
 embarrassment and a minor confusion.  Detect such an input and
 offer to skip the backup files when sending the patches out.

 Will merge to 'next'.
 Perhaps people will enhance it more once it gains more visibility.


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
 This also really needs review.


* dt/index-helper (2016-06-27) 21 commits
 - unix-socket.c: add stub implementation when unix sockets are not supported
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

 Expecting a reroll.
 ($gmane/298331, $gmane/298319).


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

 While I think it would make it easier for people to experiment and
 build on if the topic is merged to 'next', I am at the same time a
 bit reluctant to merge an unproven new topic that introduces a new
 file format, which we may end up having to support til the end of
 time.  Comments?


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 ($gmane/282594)
