From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2013, #04; Wed, 15)
Date: Wed, 15 May 2013 16:42:49 -0700
Message-ID: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 01:43:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UclLl-000617-D6
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 01:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab3EOXmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 19:42:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab3EOXmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 19:42:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F36821FF31;
	Wed, 15 May 2013 23:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	dQwAtpX1NjEmCHeIJv8vq+PdvU=; b=oKsvzSf+f1HNlbtJgVAx63zBDisbuljPx
	/PeVVHCkdlULbjzN2w8m9Jvp7oMPZToxlHUfsvhVwH2dWabC0xMNubnXrlQUGLB+
	xqVfrXqUjszzj89JgIiBFV5Co0HYzHMdPVMDxqNIdXS+MVpyDrJ7I/Jn5xwJ7Cr/
	v7PRBtdTSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ozT
	twiWmjPuwi/JIQ2RIeS9dZWwQFLFwFLd5UIePA3Fmv3kNYxb8NeQG3mVGivxAGTj
	9R75gCCQ3qBwUfafrMquelZ4Idcrp/NMYPB78heUFpwLAijKo2nxH8xR85rJQ3W5
	rxmmOMm6EGaQp2XN7Sjlhn1dJT9aEbV/MtVOA6+A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5BA71FF30;
	Wed, 15 May 2013 23:42:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95F6A1FF2C;
	Wed, 15 May 2013 23:42:50 +0000 (UTC)
X-master-at: 0c2b1cf812be6e7e35bed0844b37e412cd232b6b
X-next-at: 2fb82f5641542fc2b7c7ba84210b67d8255297c8
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27A4D058-BDB9-11E2-9892-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224458>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

We are past -rc2 and haven't seen any regression reported since the
feature freeze started, which may be a good sign (the coming release
is perfect) or a bad sign (nobody is testing).  We'll see soon when
we tag the 1.8.3 final sometime next week.  We may see subsystem
(git-svn? gitk? git-gui?) and l10n updates before that happens.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* dw/asciidoc-sources-are-dot-txt-files (2013-05-10) 1 commit
 - CodingGuidelines: Documentation/*.txt are the sources


* fc/doc-style (2013-05-09) 2 commits
 - SQUASH??? more consistently update docs
 - documentation: trivial style cleanups


* da/darwin (2013-05-15) 3 commits
 - imap-send: eliminate HMAC deprecation warnings on Mac OS X
 - cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
 - Makefile: fix default regex settings on Darwin

 Waiting for polishing discussion to finish.


* fc/macos-x-clipped-write (2013-05-10) 2 commits
 - SQUASH???
 - compate/clipped-write.c: large write(2) fails on Mac OS X/XNU

 The tip needs to be squashed, as it was reported to have tested OK.


* fc/remote-hg (2013-05-15) 39 commits
 - remote-hg: remove files before modifications
 - remote-hg: improve lightweight tag author
 - remote-hg: use remote 'default' not local one
 - remote-hg: improve branch listing
 - remote-hg: simplify branch_tip()
 - remote-hg: check diverged bookmarks
 - remote-hg: pass around revision refs
 - remote-hg: implement custom checkheads()
 - remote-hg: implement custom push()
 - remote-hg: only update necessary revisions
 - remote-hg: force remote bookmark push selectively
 - remote-hg: reorganize bookmark handling
 - remote-hg: add test for failed double push
 - remote-hg: add test for big push
 - remote-hg: add test for new bookmark special
 - remote-hg: add test for bookmark diverge
 - remote-hg: add test for diverged push
 - remote-hg: add test to push new bookmark
 - remote-hg: add remote tests
 - remote-hg: add check_bookmark() test helper
 - remote-bzr: simplify test checks
 - remote-hg: always point HEAD to master
 - remote-hg: improve progress calculation
 - remote-hg: trivial cleanups
 - remote-hg: ensure remote rebasing works
 - remote-hg: upgrade version 1 marks
 - remote-hg: switch from revisions to SHA-1 noteids
 - remote-hg: add version checks to the marks
 - remote-hg: improve node traversing
 - remote-hg: shuffle some code
 - remote-hg: use a shared repository store
 - remote-hg: load all extensions
 - remote-hg: test: simplify previous branch checkout
 - remote-helpers: test: simplify remote URLs
 - remote-helpers: tests: general improvements
 - remote-helpers: test: cleanup style
 - remote-helpers: test: cleanup white-spaces
 - remote-hg: trivial reorganization
 - remote-hg: test: be a little more quiet

 Probably will be one of the early topics to graduate post 1.8.3.


* hv/config-from-blob (2013-05-12) 5 commits
 - do not die when error in config parsing of buf occurs
 - teach config --blob option to parse config from database
 - config: make parsing stack struct independent from actual data source
 - config: drop cf validity check in get_next_char()
 - config: factor out config file stack management


* jc/t5551-posix-sed-bre (2013-05-12) 1 commit
 - t5551: do not use unportable sed '\+'

 Not a regression fix and not urgent.


* jk/fetch-always-update-tracking (2013-05-12) 4 commits
 - fetch: opportunistically update tracking refs
 - refactor "ref->merge" flag
 - fetch/pull doc: untangle meaning of bare <ref>
 - t5510: start tracking-ref tests from a known state

 "git fetch origin master" unlike "git fetch origin" or "git fetch"
 does not update "refs/remotes/origin/master" and it was an early
 design decision to keep the update of remote tracking branches
 predictable, but in practice it turns out that people find it more
 convenient to opportunisticly update them whenever we have a
 chance, and we have been updating them when we run "git push" which
 already breaks the original "predictability" anyway.


* nd/clone-connectivity-shortcut (2013-05-11) 4 commits
 - clone: open a shortcut for connectivity check
 - index-pack: remove dead code (it should never happen)
 - fetch-pack: prepare updated shallow file before fetching the pack
 - clone: let the user know when check_everything_connected is run


* rr/rebase-autostash (2013-05-12) 7 commits
 - rebase: implement --[no-]autostash and rebase.autostash
 - rebase --merge: return control to caller, for housekeeping
 - rebase -i: return control to caller, for housekeeping
 - am: return control to caller, for housekeeping
 - rebase: prepare to do generic housekeeping
 - rebase -i: don't error out if $state_dir already exists
 - am: tighten a conditional that checks for $dotest


* kb/ancestry-path-threedots (2013-05-13) 1 commit
 - t6019: demonstrate --ancestry-path A...B breakage
 (this branch is used by kb/full-history-compute-treesame-carefully-2.)


* kb/full-history-compute-treesame-carefully-2 (2013-05-13) 11 commits
 - revision.c: treat A...B merge bases as if manually specified
 - revision.c: discount side branches when computing TREESAME
 - simplify-merges: drop merge from irrelevant side branch
 - simplify-merges: never remove all TREESAME parents
 - t6012: update test for tweaked full-history traversal
 - revision.c: Make --full-history consider more merges
 - rev-list-options.txt: correct TREESAME for P
 - t6111: allow checking the parents as well
 - t6111: new TREESAME test set
 - t6019: test file dropped in -s ours merge
 - decorate.c: compact table when growing
 (this branch uses kb/ancestry-path-threedots.)

 Major update to a very core part of the system to improve culling
 of irrelevant parents while traversing a mergy history.

 Will not be a 1.8.3 material, but is an important topic.


* jc/strbuf-branchname-fix (2013-05-15) 1 commit
 - strbuf_branchname(): do not double-expand @{-1}~22

 "git merge @{-1}~22" was rewritten to "git merge frotz@{1}~22"
 incorrectly when your previous branch was "frotz" (it should be
 rewritten to "git merge frotz~22" instead).


* mk/combine-diff-context-horizon-fix (2013-05-15) 1 commit
 - combine-diff.c: Fix output when changes are exactly 3 lines apart

 "git diff -c -p" was not showing a deleted line from a hunk when
 another hunk immediately begins where the earlier one ends.


* mm/color-auto-default (2013-05-15) 2 commits
 - make color.ui default to 'auto'
 - config: refactor management of color.ui's default value

 Flip the default for color.ui to 'auto', which is what many
 tutorials recommend new users to do.


* tr/coverage (2013-05-13) 4 commits
 - coverage: build coverage-untested-functions by default
 - coverage: set DEFAULT_TEST_TARGET to avoid using prove
 - coverage: do not delete .gcno files before building
 - coverage: split build target into compile and test

 Update the test coverage support that was left to bitrot for some
 time.

--------------------------------------------------
[Stalled]

* mh/multimail (2013-04-21) 1 commit
 - git-multimail: a replacement for post-receive-email

 Waiting for the initial history to pull from.
 $gmane/223564


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Waiting for a reroll after a review.


* jk/commit-info-slab (2013-04-19) 3 commits
 - commit-slab: introduce a macro to define a slab for new type
 - commit-slab: avoid large realloc
 - commit: allow associating auxiliary info on-demand
 (this branch is used by jc/show-branch.)

 Technology demonstration to show a way we could use unbound number
 of flag bits on commit objects.


* jn/config-ignore-inaccessible (2013-04-15) 1 commit
  (merged to 'next' on 2013-05-07 at 4f09e24)
 + config: allow inaccessible configuration under $HOME

 When $HOME is misconfigured to point at an unreadable directory, we
 used to complain and die. This loosens the check.

--------------------------------------------------
[Cooking]

* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Looked reasonable, I think.  Comments?


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 I think this is being rerolled using strbuf_expand().


* nd/clone-local-with-colon (2013-05-07) 1 commit
 - clone: allow cloning local paths with colons in them

 "git clone foo/bar:baz" cannot be a request to clone from a remote
 over git-over-ssh specified in the scp style.  Detect this case and
 clone from a local repository at "foo/bar:baz".


* nd/warn-ambiguous-object-name (2013-05-07) 1 commit
 - get_sha1: improve ambiguity warning regarding SHA-1 and ref names

 "git cmd <name>", when <name> happens to be a 40-hex string,
 directly uses the 40-hex string as an object name, even if a ref
 "refs/<some hierarchy>/<name>" exists.  This disambiguation order
 is unlikely to change, but we should warn about the ambiguity just
 like we warn when more than one refs/ hierachies share the same
 name.

 The message needs to be fixed up, as this is not "refname is
 ambiguous".


* fc/zsh-leftover-bits (2013-05-08) 2 commits
 - completion: synchronize zsh wrapper
 - completion: cleanup zsh wrapper


* rs/empty-archive (2013-05-09) 2 commits
 - t5004: resurrect original empty tar archive test
 - t5004: avoid using tar for checking emptiness of archive

 Fixes tests added in 1.8.2 era that are broken on BSDs,
 but it is not all that urgent.


* vv/help-unknown-ref (2013-05-08) 2 commits
 - merge: use help_unknown_ref()
 - help: add help_unknown_ref()

 Detect "git merge foo" that might have meant "git merge origin/foo"
 and give an error message that is more specific than "foo is not
 something we can merge".


* fc/fast-export-persistent-marks (2013-05-07) 3 commits
 - fast-{import,export}: use get_sha1_hex() to read from marks file
 - fast-export: don't parse commits while reading marks file
 - fast-export: do not parse non-commit objects while reading marks file

 Optimization for fast-export by avoiding unnecessarily resolving
 arbitrary object name and parsing object when only presence and
 type information is necessary, etc.


* jc/core-checkstat-2.0 (2013-05-06) 2 commits
 - core.statinfo: remove as promised in Git 2.0
 - deprecate core.statinfo at Git 2.0 boundary

 The bottom one is a fix for a breakage of a new feature in 1.8.2
 but it is not all that urgent.


* jk/packed-refs-race (2013-05-06) 4 commits
 - for_each_ref: load all loose refs before packed refs
 - get_packed_refs: reload packed-refs file when it changes
 - add a stat_validity struct
 - resolve_ref: close race condition for packed refs


* fc/at-head (2013-05-08) 13 commits
 - sha1_name: compare variable with constant, not constant with variable
 - Add new @ shortcut for HEAD
 - sha1_name: refactor reinterpret()
 - sha1_name: check @{-N} errors sooner
 - sha1_name: reorganize get_sha1_basic()
 - sha1_name: don't waste cycles in the @-parsing loop
 - sha1_name: remove unnecessary braces
 - sha1_name: remove no-op
 - tests: at-combinations: @{N} versus HEAD@{N}
 - tests: at-combinations: increase coverage
 - tests: at-combinations: improve nonsense()
 - tests: at-combinations: check ref names directly
 - tests: at-combinations: simplify setup

 Instead of typing four capital letters "HEAD", you can say "@"
 instead.


* jk/lookup-object-prefer-latest (2013-05-02) 1 commit
  (merged to 'next' on 2013-05-06 at cc59dcc)
 + lookup_object: prioritize recently found objects

 Optimizes object lookup when the object hashtable starts to become
 crowded.


* jk/subtree-do-not-push-if-split-fails (2013-05-01) 1 commit
  (merged to 'next' on 2013-05-06 at 81bdf37)
 + contrib/subtree: don't delete remote branches if split fails

 "git subtree" (in contrib/) had one codepath with loose error
 checks to lose data at the remote side.


* fc/completion (2013-04-27) 9 commits
 - completion: remove __git_index_file_list_filter()
 - completion: add space after completed filename
 - completion: add hack to enable file mode in bash < 4
 - completion: refactor __git_complete_index_file()
 - completion: refactor diff_index wrappers
 - completion: use __gitcompadd for __gitcomp_file
 - completion; remove unuseful comments
 - completion: document tilde expansion failure in tests
 - completion: add file completion tests

 I saw this discussed somewhat. Is everybody happy with this
 version?  This is its v2, in the $gmane/222682 thread.


* jk/test-output (2013-05-06) 3 commits
  (merged to 'next' on 2013-05-06 at 7c03af3)
 + t/Makefile: don't define TEST_RESULTS_DIRECTORY recursively
  (merged to 'next' on 2013-05-01 at 63827c9)
 + test output: respect $TEST_OUTPUT_DIRECTORY
 + t/Makefile: fix result handling with TEST_OUTPUT_DIRECTORY

 When TEST_OUTPUT_DIRECTORY setting is used, it was handled somewhat
 inconsistently between the test framework and t/Makefile, and logic
 to summarize the results looked at a wrong place.

 Will cook in 'next'.


* rj/mingw-cygwin (2013-05-08) 2 commits
 - cygwin: Remove the CYGWIN_V15_WIN32API build variable
 - mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE

 Update build for Cygwin 1.[57].  There seems to be an ongoing
 discussion on the list.


* rj/sparse (2013-04-28) 10 commits
  (merged to 'next' on 2013-05-01 at 649e16c)
 + sparse: Fix mingw_main() argument number/type errors
 + compat/mingw.c: Fix some sparse warnings
 + compat/win32mmap.c: Fix some sparse warnings
 + compat/poll/poll.c: Fix a sparse warning
 + compat/win32/pthread.c: Fix a sparse warning
 + compat/unsetenv.c: Fix a sparse warning
 + compat/nedmalloc: Fix compiler warnings on linux
 + compat/nedmalloc: Fix some sparse warnings
 + compat/fnmatch/fnmatch.c: Fix a sparse error
 + compat/regex/regexec.c: Fix some sparse warnings

 Will cook in 'next'.


* js/transport-helper-error-reporting-fix (2013-04-28) 13 commits
  (merged to 'next' on 2013-04-29 at 8cc4bb8)
 + git-remote-testgit: build it to run under $SHELL_PATH
 + git-remote-testgit: further remove some bashisms
 + git-remote-testgit: avoid process substitution
  (merged to 'next' on 2013-04-25 at 3358f1a)
 + t5801: "VAR=VAL shell_func args" is forbidden
  (merged to 'next' on 2013-04-22 at 5ba6467)
 + transport-helper: update remote helper namespace
 + transport-helper: trivial code shuffle
 + transport-helper: warn when refspec is not used
 + transport-helper: clarify pushing without refspecs
 + transport-helper: update refspec documentation
 + transport-helper: clarify *:* refspec
 + transport-helper: improve push messages
 + transport-helper: mention helper name when it dies
 + transport-helper: report errors properly
 (this branch is tangled with fc/transport-helper-error-reporting.)

 Finishing touches to fc/transport-helper-error-reporting topic.
 Will cook in 'next'.


* mh/fetch-into-shallow (2013-05-02) 2 commits
  (merged to 'next' on 2013-05-03 at 3fadc61)
 + t5500: add test for fetching with an unknown 'shallow'
  (merged to 'next' on 2013-04-29 at a167d3e)
 + upload-pack: ignore 'shallow' lines with unknown obj-ids

 Will cook in 'next'.


* jh/checkout-auto-tracking (2013-04-21) 8 commits
  (merged to 'next' on 2013-04-22 at 2356700)
 + glossary: Update and rephrase the definition of a remote-tracking branch
 + branch.c: Validate tracking branches with refspecs instead of refs/remotes/*
 + t9114.2: Don't use --track option against "svn-remote"-tracking branches
 + t7201.24: Add refspec to keep --track working
 + t3200.39: tracking setup should fail if there is no matching refspec.
 + checkout: Use remote refspecs when DWIMming tracking branches
 + t2024: Show failure to use refspec when DWIMming remote branch names
 + t2024: Add tests verifying current DWIM behavior of 'git checkout <branch>'

 Updates "git checkout foo" that DWIMs the intended "upstream" and
 turns it into "git checkout -t -b foo remotes/origin/foo" to
 correctly take existing remote definitions into account.  The
 remote "origin" may be what uniquely map its own branch to
 remotes/some/where/foo but that some/where may not be "origin".

 Will cook in 'next'.


* jc/prune-all (2013-04-25) 4 commits
  (merged to 'next' on 2013-04-26 at 97a7387)
 + prune: introduce OPT_EXPIRY_DATE() and use it
  (merged to 'next' on 2013-04-22 at b00ccf6)
 + api-parse-options.txt: document "no-" for non-boolean options
 + git-gc.txt, git-reflog.txt: document new expiry options
 + date.c: add parse_expiry_date()
 (this branch is used by mh/packed-refs-various.)

 We used the approxidate() parser for "--expire=<timestamp>" options
 of various commands, but it is better to treat --expire=all and
 --expire=now a bit more specially than using the current timestamp.
 Update "git gc" and "git reflog" with a new parsing function for
 expiry dates.

 Will cook in 'next'.


* as/check-ignore (2013-04-29) 6 commits
  (merged to 'next' on 2013-04-30 at 646931f)
 + t0008: use named pipe (FIFO) to test check-ignore streaming
  (merged to 'next' on 2013-04-21 at 7515aa8)
 + Documentation: add caveats about I/O buffering for check-{attr,ignore}
 + check-ignore: allow incremental streaming of queries via --stdin
 + check-ignore: move setup into cmd_check_ignore()
 + check-ignore: add -n / --non-matching option
 + t0008: remove duplicated test fixture data

 Enhance "check-ignore" (1.8.2 update) to work more like "check-attr"
 over bidi-pipes.

 Will cook in 'next'.


* mh/packed-refs-various (2013-05-01) 33 commits
  (merged to 'next' on 2013-05-01 at e527153)
 + refs: handle the main ref_cache specially
 + refs: change do_for_each_*() functions to take ref_cache arguments
 + pack_one_ref(): do some cheap tests before a more expensive one
 + pack_one_ref(): use write_packed_entry() to do the writing
 + pack_one_ref(): use function peel_entry()
 + refs: inline function do_not_prune()
 + pack_refs(): change to use do_for_each_entry()
 + refs: use same lock_file object for both ref-packing functions
 + pack_one_ref(): rename "path" parameter to "refname"
 + pack-refs: merge code from pack-refs.{c,h} into refs.{c,h}
 + pack-refs: rename handle_one_ref() to pack_one_ref()
 + refs: extract a function write_packed_entry()
 + repack_without_ref(): write peeled refs in the rewritten file
 + t3211: demonstrate loss of peeled refs if a packed ref is deleted
 + refs: change how packed refs are deleted
 + search_ref_dir(): return an index rather than a pointer
 + repack_without_ref(): silence errors for dangling packed refs
 + t3210: test for spurious error messages for dangling packed refs
 + refs: change the internal reference-iteration API
 + refs: extract a function peel_entry()
 + peel_ref(): fix return value for non-peelable, not-current reference
 + peel_object(): give more specific information in return value
 + refs: extract function peel_object()
 + refs: extract a function ref_resolves_to_object()
 + repack_without_ref(): use function get_packed_ref()
 + peel_ref(): use function get_packed_ref()
 + get_packed_ref(): return a ref_entry
 + do_for_each_ref_in_dirs(): remove dead code
 + refs: define constant PEELED_LINE_LENGTH
 + refs: document how current_ref is used
 + refs: document do_for_each_ref() and do_one_ref()
 + refs: document the fields of struct ref_value
 + refs: document flags constants REF_*
 (this branch uses jc/prune-all.)

 Updates reading and updating packed-refs file, correcting corner
 case bugs.

 Will cook in 'next'.


* fc/transport-helper-error-reporting (2013-05-10) 12 commits
  (merged to 'next' on 2013-05-10 at 2a9af4b)
 + transport-helper: fix remote helper namespace regression
 + test: remote-helper: add missing and
  (merged to 'next' on 2013-04-25 at 3358f1a)
 + t5801: "VAR=VAL shell_func args" is forbidden
  (merged to 'next' on 2013-04-22 at 5ba6467)
 + transport-helper: update remote helper namespace
 + transport-helper: trivial code shuffle
 + transport-helper: warn when refspec is not used
 + transport-helper: clarify pushing without refspecs
 + transport-helper: update refspec documentation
 + transport-helper: clarify *:* refspec
 + transport-helper: improve push messages
 + transport-helper: mention helper name when it dies
 + transport-helper: report errors properly
 (this branch is tangled with js/transport-helper-error-reporting-fix.)

 Update transport helper to report errors and maintain ref hierarchy
 used to keep track of remote helper state better.

 Will cook in 'next'.


* jk/submodule-subdirectory-ok (2013-04-24) 3 commits
  (merged to 'next' on 2013-04-24 at 6306b29)
 + submodule: fix quoting in relative_path()
  (merged to 'next' on 2013-04-22 at f211e25)
 + submodule: drop the top-level requirement
 + rev-parse: add --prefix option

 Allow various subcommands of "git submodule" to be run not from the
 top of the working tree of the superproject.

 Will cook in 'next'.


* jl/submodule-mv (2013-04-23) 5 commits
  (merged to 'next' on 2013-04-23 at c04f574)
 + submodule.c: duplicate real_path's return value
  (merged to 'next' on 2013-04-19 at 45ae3c9)
 + rm: delete .gitmodules entry of submodules removed from the work tree
 + Teach mv to update the path entry in .gitmodules for moved submodules
 + Teach mv to move submodules using a gitfile
 + Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Will cook in 'next'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* nd/magic-pathspecs (2013-03-31) 45 commits
 . Rename field "raw" to "_raw" in struct pathspec
 . pathspec: support :(glob) syntax
 . pathspec: make --literal-pathspecs disable pathspec magic
 . pathspec: support :(literal) syntax for noglob pathspec
 . Kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 . parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 . parse_pathspec: make sure the prefix part is wildcard-free
 . tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 . Remove match_pathspec() in favor of match_pathspec_depth()
 . Remove init_pathspec() in favor of parse_pathspec()
 . Remove diff_tree_{setup,release}_paths
 . Convert common_prefix() to use struct pathspec
 . Convert add_files_to_cache to take struct pathspec
 . Convert {read,fill}_directory to take struct pathspec
 . Convert refresh_index to take struct pathspec
 . Convert report_path_error to take struct pathspec
 . checkout: convert read_tree_some to take struct pathspec
 . Convert unmerge_cache to take struct pathspec
 . Convert run_add_interactive to use struct pathspec
 . Convert read_cache_preload() to take struct pathspec
 . reset: convert to use parse_pathspec
 . add: convert to use parse_pathspec
 . check-ignore: convert to use parse_pathspec
 . archive: convert to use parse_pathspec
 . ls-files: convert to use parse_pathspec
 . rm: convert to use parse_pathspec
 . checkout: convert to use parse_pathspec
 . rerere: convert to use parse_pathspec
 . status: convert to use parse_pathspec
 . commit: convert to use parse_pathspec
 . clean: convert to use parse_pathspec
 . Guard against new pathspec magic in pathspec matching code
 . parse_pathspec: support prefixing original patterns
 . parse_pathspec: support stripping/checking submodule paths
 . parse_pathspec: support stripping submodule trailing slashes
 . parse_pathspec: a special flag for max_depth feature
 . Convert some get_pathspec() calls to parse_pathspec()
 . parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
 . parse_pathspec: save original pathspec for reporting
 . Add parse_pathspec() that converts cmdline args to struct pathspec
 . pathspec: add copy_pathspec
 . pathspec: i18n-ize error strings in pathspec parsing code
 . Move struct pathspec and related functions to pathspec.[ch]
 . clean: remove unused variable "seen"
 . setup.c: check that the pathspec magic ends with ")"

 Migrate the rest of codebase to use "struct pathspec" more.

 This has nasty conflicts with kb/status-ignored-optim-2,
 as/check-ignore and tr/line-log; I've already asked Duy to hold
 this and later rebase on top of them.

 Will defer.


* tr/line-log (2013-04-22) 13 commits
  (merged to 'next' on 2013-04-22 at 8f2c1de)
 + git-log(1): remove --full-line-diff description
  (merged to 'next' on 2013-04-21 at cd92620)
 + line-log: fix documentation formatting
  (merged to 'next' on 2013-04-15 at 504559e)
 + log -L: improve comments in process_all_files()
 + log -L: store the path instead of a diff_filespec
 + log -L: test merge of parallel modify/rename
 + t4211: pass -M to 'git log -M -L...' test
  (merged to 'next' on 2013-04-05 at 5afb00c)
 + log -L: fix overlapping input ranges
 + log -L: check range set invariants when we look it up
  (merged to 'next' on 2013-04-01 at 5be920c)
 + Speed up log -L... -M
 + log -L: :pattern:file syntax to find by funcname
 + Implement line-history search (git log -L)
 + Export rewrite_parents() for 'log -L'
 + Refactor parse_loc

 Will cook in 'next'.


* jc/push-2.0-default-to-simple (2013-04-03) 1 commit
 - push: switch default from "matching" to "simple"

 The early bits to adjust the tests have been merged to 'master'.

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.

--------------------------------------------------
[Discarded]

* kb/full-history-compute-treesame-carefully (2013-05-06) 11 commits
 . revision.c: treat A...B merge bases as if manually specified
 . revision.c: discount side branches when computing TREESAME
 . simplify-merges: drop merge from irrelevant side branch
 . simplify-merges: never remove all TREESAME parents
 . t6012: update test for tweaked full-history traversal
 . revision.c: Make --full-history consider more merges
 . rev-list-options.txt: correct TREESAME for P
 . t6111: allow checking the parents as well
 . t6111: new TREESAME test set
 . t6019: test file dropped in -s ours merge
 . decorate.c: compact table when growing

 Superseded by kb/full-history-compute-treesame-carefully-2
