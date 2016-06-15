From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2013, #05; Sat, 15)
Date: Sat, 15 Jun 2013 23:00:19 -0700
Message-ID: <7vehc2k32k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 08:00:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo60p-0007uo-VY
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 08:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab3FPGAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 02:00:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37175 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab3FPGAW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 02:00:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E776B1A941;
	Sun, 16 Jun 2013 06:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	rrPrEAHP+Fwo+f7fZrBofjGoTI=; b=WdZO5g7vB/6TjX6iK98xBPPqMJPBTYfrv
	y9rDymTQ3i8ao6oihafOLtoyEvledn5cM4X2XYTG24XABM4Pw74K+ODpr2uzmeVH
	B2pOUZuhkdduDOEcm7IV7XB/ZU2Fxgt4r+IXHeEyrT3BJY02hOFvopzphUNazMT8
	avPFH2DaNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=glq
	0xmriO3sbzNTMmc0zw0epi9T9TiylD0EsTpzhd84McuQ1/fORfNRy6LhVzJBWURw
	c0AiSM5ugkgWLy9/48ZzK9hshHtW1mglmquqX/Uv0BtNyT5abxl3oGf7EB88LUpy
	Hr4eO7p6sOdBrlYEalVZ1LHTwAVX49MhuM0Nc5DE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D998B1A940;
	Sun, 16 Jun 2013 06:00:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98DD81A93E;
	Sun, 16 Jun 2013 06:00:20 +0000 (UTC)
X-master-at: 0dbd81251dbc516bb3bf07862c369fc582a4e5e0
X-next-at: 22819c950c7ed8ce0f8755d6134a6eae6064f6d0
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06E8656A-D64A-11E2-A798-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227990>

What's cooking in git.git (Jun 2013, #05; Sat, 15)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bp/mediawiki-credential (2013-06-05) 1 commit
  (merged to 'next' on 2013-06-05 at ea07ec1)
 + git-remote-mediawiki: use Git.pm functions for credentials

 The bridge to MediaWiki has been updated to use the credential
 helper interface in Git.pm, losing its own and the original
 implementation the former was based on.


* kb/full-history-compute-treesame-carefully-2 (2013-05-16) 15 commits
  (merged to 'next' on 2013-06-05 at 193242b)
 + revision.c: make default history consider bottom commits
 + revision.c: don't show all merges for --parents
 + revision.c: discount side branches when computing TREESAME
 + revision.c: add BOTTOM flag for commits
 + simplify-merges: drop merge from irrelevant side branch
 + simplify-merges: never remove all TREESAME parents
 + t6012: update test for tweaked full-history traversal
 + revision.c: Make --full-history consider more merges
 + Documentation: avoid "uninteresting"
 + rev-list-options.txt: correct TREESAME for P
 + t6111: add parents to tests
 + t6111: allow checking the parents as well
 + t6111: new TREESAME test set
 + t6019: test file dropped in -s ours merge
 + decorate.c: compact table when growing

 Major update to a very core part of the revision traversal logic to
 improve culling of irrelevant parents while traversing a mergy
 history.


* mh/reflife (2013-06-02) 25 commits
  (merged to 'next' on 2013-06-05 at 291d863)
 + refs: document the lifetime of the args passed to each_ref_fn
 + register_ref(): make a copy of the bad reference SHA-1
 + exclude_existing(): set existing_refs.strdup_strings
 + string_list_add_refs_by_glob(): add a comment about memory management
 + string_list_add_one_ref(): rename first parameter to "refname"
 + show_head_ref(): rename first parameter to "refname"
 + show_head_ref(): do not shadow name of argument
 + add_existing(): do not retain a reference to sha1
 + do_fetch(): clean up existing_refs before exiting
 + do_fetch(): reduce scope of peer_item
 + object_array_entry: fix memory handling of the name field
 + find_first_merges(): remove unnecessary code
 + find_first_merges(): initialize merges variable using initializer
 + fsck: don't put a void*-shaped peg in a char*-shaped hole
 + object_array_remove_duplicates(): rewrite to reduce copying
 + revision: use object_array_filter() in implementation of gc_boundary()
 + object_array: add function object_array_filter()
 + revision: split some overly-long lines
 + cmd_diff(): make it obvious which cases are exclusive of each other
 + cmd_diff(): rename local variable "list" -> "entry"
 + cmd_diff(): use an object_array for holding trees
 + builtin_diff_tree(): make it obvious that function wants two entries
 + add_rev_cmdline(): make a copy of the name argument
 + fetch: make own copies of refnames
 + describe: make own copy of refname
 (this branch is used by mh/ref-races.)

 Define memory ownership and lifetime rules for what for-each-ref
 feeds to its callbacks (in short, "you do not own it, so make a
 copy if you want to keep it").


* mt/send-email-cc-match-fix (2013-06-05) 7 commits
  (merged to 'next' on 2013-06-06 at e4d0831)
 + test-send-email: test for pre-sanitized self name
 + t/send-email: test suppress-cc=self with non-ascii
 + t/send-email: add test with quoted sender
 + send-email: make --suppress-cc=self sanitize input
 + t/send-email: test suppress-cc=self on cccmd
 + send-email: fix suppress-cc=self on cccmd
 + t/send-email.sh: add test for suppress-cc=self

 Logic git-send-email used to suppress cc mishandled names like "A
 U. Thor" <author@example.xz>, where the human readable part needs
 to be quoted (the user input may not have the double quotes around
 the name, and comparison was done between quoted and unquoted
 strings).


* rr/complete-difftool-fixup (2013-06-09) 2 commits
  (merged to 'next' on 2013-06-11 at fe91170)
 + completion: show can take both revlist and paths
 + completion: difftool takes both revs and files
 (this branch is tangled with rr/complete-difftool.)

 "git difftool" can take both revs to be compared and pathspecs.
 "git show" takes revs, revs:path and pathspecs.


* rr/remove-contrib-some (2013-06-12) 2 commits
  (merged to 'next' on 2013-06-12 at 797644c)
 + contrib: drop blameview/ directory
  (merged to 'next' on 2013-06-05 at fc15705)
 + contrib: remove continuous/ and patches/

 Remove stale contrib/ material.

--------------------------------------------------
[New Topics]

* rr/prompt-rebase-breakage-fix (2013-06-14) 1 commit
 - prompt: squelch error output from cat

 Will merge to 'next'.


* jh/libify-note-handling (2013-06-12) 3 commits
 - Move create_notes_commit() from notes-merge.c into notes-utils.c
 - Move copy_note_for_rewrite + friends from builtin/notes.c to notes-utils.c
 - finish_copy_notes_for_rewrite(): Let caller provide commit message


* jk/add-i-custom-diff-algo (2013-06-12) 1 commit
 - add--interactive: respect diff.algorithm

 Will merge to 'next'.


* mh/ref-races (2013-06-11) 13 commits
 - refs: do not invalidate the packed-refs cache unnecessarily
 - for_each_ref: load all loose refs before packed refs
 - get_packed_ref_cache: reload packed-refs file when it changes
 - add a stat_validity struct
 - Extract a struct stat_data from cache_entry
 - packed_ref_cache: increment refcount when locked
 - do_for_each_entry(): increment the packed refs cache refcount
 - refs: manage lifetime of packed refs cache via reference counting
 - refs: implement simple transactions for the packed-refs file
 - refs: wrap the packed refs cache in a level of indirection
 - pack_refs(): split creation of packed refs and entry writing
 - repack_without_ref(): split list curation and entry writing
 - Merge branch 'mh/packed-refs-various' into mh/ref-races


* mm/rm-coalesce-errors (2013-06-12) 2 commits
 - rm: introduce advice.rmHints to shorten messages
 - rm: better error message on failure for multiple files


* rr/am-quit-empty-then-abort-fix (2013-06-14) 2 commits
 - SQUASH???
 - am: handle stray $dotest directory


* rs/logical-vs-binary-or (2013-06-13) 1 commit
  (merged to 'next' on 2013-06-14 at 2821441)
 + use logical OR (||) instead of binary OR (|) in logical context

 Code cleanup.

 Will merge to 'master'.


* rs/match-trees-refactor (2013-06-13) 1 commit
  (merged to 'next' on 2013-06-14 at 1904928)
 + match-trees: factor out fill_tree_desc_strict

 Code cleanup.

 Will merge to 'master'.


* fg/submodule-non-ascii-path (2013-06-14) 1 commit
 - handle multibyte characters in name

 Many "git submodule" operations do not work on a submodule at a
 path whose name is not in ASCII.

 Will merge to 'next'.


* rr/rebase-autostash (2013-06-13) 3 commits
 - rebase: finish_rebase() in noop rebase
 - rebase: finish_rebase() in fast-forward rebase
 - rebase: guard against missing files in read_basic_state()

 Will merge to 'next'.


* bp/remote-mw-tests (2013-06-14) 1 commit
 - git-remote-mediawiki: remove hardcoded version number in the test suite

 Will merge to 'next'.


* cm/remote-mediawiki-perlcritique (2013-06-14) 31 commits
 - git-remote-mediawiki: make error message more precise
 - git-remote-mediawiki: add a perlcritic rule in Makefile
 - git-remote-mediawiki: add a .perlcriticrc file
 - git-remote-mediawiki: clearly rewrite double dereference
 - git-remote-mediawiki: fix a typo ("mediwiki" instead of "mediawiki")
 - git-remote-mediawiki: put non-trivial numeric values in constants.
 - git-remote-mediawiki: don't use quotes for empty strings
 - git-remote-mediawiki: replace "unless" statements with negated "if" statements
 - git-remote-mediawiki: brace file handles for print for more clarity
 - git-remote-mediawiki: modify strings for a better coding-style
 - git-remote-mediawiki: put long code into a subroutine
 - git-remote-mediawiki: remove import of unused open2
 - git-remote-mediawiki: check return value of open
 - git-remote-mediawiki: assign a variable as undef and make proper indentation
 - git-remote-mediawiki: rename a variable ($last) which has the name of a keyword
 - git-remote-mediawiki: remove unused variable $entry
 - git-remote-mediawiki: turn double-negated expressions into simple expressions
 - git-remote-mediawiki: change the name of a variable
 - git-remote-mediawiki: add newline in the end of die() error messages
 - git-remote-mediawiki: change style in a regexp
 - git-remote-mediawiki: change style in a regexp
 - git-remote-mediawiki: change separator of some regexps
 - git-remote-mediawiki: change the behaviour of a split
 - git-remote-mediawiki: remove useless regexp modifier (m)
 - git-remote-mediawiki: rewrite unclear line of instructions
 - git-remote-mediawiki: change syntax of map calls
 - git-remote-mediawiki: move a variable declaration at the top of the code
 - git-remote-mediawiki: always end a subroutine with a return
 - git-remote-mediawiki: replace :utf8 by :encoding(UTF-8)
 - git-remote-mediawiki: move "use warnings;" before any instruction
 - git-remote-mediawiki: make a regexp clearer

 Will merge to 'next'.


* jk/apache-test-for-2.4 (2013-06-14) 4 commits
 - t/lib-httpd/apache.conf: configure an MPM module for apache 2.4
 - t/lib-httpd/apache.conf: load compat access module in apache 2.4
 - t/lib-httpd/apache.conf: load extra auth modules in apache 2.4
 - t/lib-httpd/apache.conf: do not use LockFile in apache >= 2.4

 Will merge to 'next'.


* rr/rebase-sha1-by-string-query (2013-06-14) 3 commits
 - rebase: use peel_committish() where appropriate
 - sh-setup: add new peel_committish() helper
 - t/rebase: add failing tests for a peculiar revision


* jk/unpack-entry-fallback-to-another (2013-06-14) 2 commits
 - unpack_entry: do not die when we fail to apply a delta
 - t5303: drop "count=1" from corruption dd

--------------------------------------------------
[Stalled]

* rr/triangle-push-fix (2013-06-09) 4 commits
 - t/push-default: test pushdefault with all modes
 - t/push-default: generalize test_push_{success, commit}
 - push: make upstream, simple work with pushdefault
 - t/push-default: remove redundant test_config lines

 Tries to apply the 'push.default = upstream' semantics to
 triangular workflow where it does not quite apply.

 Waiting for a reroll.


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

 Expecting a reroll, as an early part of a larger series.


* jk/submodule-subdirectory-ok (2013-04-24) 3 commits
 - submodule: fix quoting in relative_path()
 - submodule: drop the top-level requirement
 - rev-parse: add --prefix option

 Allow various subcommands of "git submodule" to be run not from the
 top of the working tree of the superproject.

 Waiting for a reroll.


* jl/submodule-mv (2013-04-23) 5 commits
 - submodule.c: duplicate real_path's return value
 - rm: delete .gitmodules entry of submodules removed from the work tree
 - Teach mv to update the path entry in .gitmodules for moved submodules
 - Teach mv to move submodules using a gitfile
 - Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Waiting for a reroll.


* jk/list-objects-sans-blobs (2013-06-06) 4 commits
 . archive: ignore blob objects when checking reachability
 . list-objects: optimize "revs->blob_objects = 0" case
 . upload-archive: restrict remote objects with reachability check
 . clear parsed flag when we free tree buffers

 Attempt to allow "archive --remote=$there $arbitrary_sha1" while
 keeping the reachability safety.

 Seems to break some tests in a trivial and obvious way.


* jk/packed-refs-race (2013-05-06) 4 commits
 . for_each_ref: load all loose refs before packed refs
 . get_packed_refs: reload packed-refs file when it changes
 . add a stat_validity struct
 . resolve_ref: close race condition for packed refs

 Will be rerolled.


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicking back to 'pu'.


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

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style
 (this branch uses jk/commit-info-slab; is tangled with jc/topo-author-date-sort.)

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* jc/topo-author-date-sort (2013-06-11) 4 commits
  (merged to 'next' on 2013-06-15 at ad4fb48)
 + log: --author-date-order
 + sort-in-topological-order: use prio-queue
 + prio-queue: priority queue of pointers to structs
 + toposort: rename "lifo" field
 (this branch uses jk/commit-info-slab; is tangled with jc/show-branch.)

 "git log" learned the "--author-date-order" option, with which the
 output is topologically sorted and commits in parallel histories
 are shown intermixed together based on the author timestamp.


* fc/makefile (2013-06-09) 4 commits
  (merged to 'next' on 2013-06-14 at 75b5f6b)
 + Makefile: use $^ to avoid listing prerequisites on the command line
 + build: do not install git-remote-testgit
 + build: generate and clean test scripts
 + Merge branch 'js/transport-helper-error-reporting-fix' into fc/makefile

 Makefile simplification.

 Will merge to 'master'.


* fc/show-non-empty-errors-in-test (2013-06-09) 1 commit
  (merged to 'next' on 2013-06-14 at 99b6b54)
 + test: test_must_be_empty helper

 Will merge to 'master'.


* nd/traces (2013-06-09) 2 commits
  (merged to 'next' on 2013-06-14 at ce0d897)
 + git.txt: document GIT_TRACE_PACKET
 + core: use env variable instead of config var to turn on logging pack access

 Will merge to 'master'.


* rs/discard-index-discard-array (2013-06-09) 2 commits
  (merged to 'next' on 2013-06-14 at 778ea9b)
 + read-cache: free cache in discard_index
 + read-cache: add simple performance test

 Will merge to 'master'.


* cm/remote-mediawiki (2013-06-11) 1 commit
  (merged to 'next' on 2013-06-15 at bdce58e)
 + git-remote-mediawiki: display message when launched directly

 Will merge to 'master'.


* jg/status-config (2013-06-15) 2 commits
  (merged to 'next' on 2013-06-15 at 2bc6547)
 + status: introduce status.branch to enable --branch by default
 + status: introduce status.short to enable --short by default

 Will merge to 'master'.


* mh/loose-refs-race-with-pack-ref (2013-06-11) 4 commits
 - resolve_ref_unsafe(): close race condition reading loose refs
 - resolve_ref_unsafe(): nest reference-reading code in an infinite loop
 - resolve_ref_unsafe(): handle the case of an SHA-1 within loop
 - resolve_ref_unsafe(): extract function handle_missing_loose_ref()


* jk/commit-info-slab (2013-06-07) 3 commits
  (merged to 'next' on 2013-06-15 at 908ab93)
 + commit-slab: introduce a macro to define a slab for new type
 + commit-slab: avoid large realloc
 + commit: allow associating auxiliary info on-demand
 (this branch is used by jc/show-branch and jc/topo-author-date-sort.)

 Allow adding custom information to commit objects in order to
 represent unbound number of flag bits etc.

 Will merge to 'master'.


* fc/sequencer-skip-quiet (2013-06-06) 5 commits
 - sequencer: run post-rewrite hook
 - cherry-pick: store rewritten commits
 - cherry-pick: add --skip-empty option
 - sequencer: avoid leaking message buffer when refusing to create an empty commit
 - sequencer: remove useless indentation

 The bottom three looked more or less reasonable.  Execution of
 post-rewrite hook could use a better refactoring from the original
 code copied from builtin/commit.c, though.

 Will discard the top 3, merge the rest to 'next'.


* js/test-ln-s-add (2013-06-07) 10 commits
  (merged to 'next' on 2013-06-14 at 9f58cb1)
 + t4011: remove SYMLINKS prerequisite
 + t6035: use test_ln_s_add to remove SYMLINKS prerequisite
 + t3509, t4023, t4114: use test_ln_s_add to remove SYMLINKS prerequisite
 + t3100: use test_ln_s_add to remove SYMLINKS prerequisite
 + t3030: use test_ln_s_add to remove SYMLINKS prerequisite
 + t0000: use test_ln_s_add to remove SYMLINKS prerequisite
 + tests: use test_ln_s_add to remove SYMLINKS prerequisite (trivial cases)
 + tests: introduce test_ln_s_add
 + t3010: modernize style
 + test-chmtime: Fix exit code on Windows

 Many tests that check the behaviour of symbolic links stored in the
 index or the tree objects do not have to be skipped on a filesystem
 that lack symbolic link support.

 Will merge to 'master'.


* mz/rebase-tests (2013-06-07) 7 commits
  (merged to 'next' on 2013-06-14 at 73f3318)
 + tests: move test for rebase messages from t3400 to t3406
 + t3406: modernize style
 + add tests for rebasing merged history
 + add tests for rebasing root
 + add tests for rebasing of empty commits
 + add tests for rebasing with patch-equivalence present
 + add simple tests of consistency across rebase types

 Will merge to 'master'.


* nd/make-wildmatch-default (2013-06-02) 1 commit
  (merged to 'next' on 2013-06-14 at cf21faa)
 + Makefile: promote wildmatch to be the default fnmatch implementation

 Will merge to 'master'.


* ap/diff-ignore-blank-lines (2013-06-10) 1 commit
 - diff: add --ignore-blank-lines option

 "git diff" learned a mode that ignores hunks whose change consists
 only of additions and removals of blank lines, which is the same as
 "diff -B" (ignore blank lines) of GNU diff.


* jx/clean-interactive (2013-06-03) 15 commits
 - test: add t7301 for git-clean--interactive
 - git-clean: add documentation for interactive git-clean
 - git-clean: add ask each interactive action
 - git-clean: add select by numbers interactive action
 - git-clean: add filter by pattern interactive action
 - git-clean: use a git-add-interactive compatible UI
 - git-clean: add colors to interactive git-clean
 - git-clean: show items of del_list in columns
 - git-clean: add support for -i/--interactive
 - git-clean: refactor git-clean into two phases
 - Refactor write_name_quoted_relative, remove unused params
 - Refactor quote_path_relative, remove unused params
 - quote.c: remove path_relative, use relative_path instead
 - path.c: refactor relative_path(), not only strip prefix
 - test: add test cases for relative_path


* tr/test-v-and-v-subtest-only (2013-05-16) 6 commits
 - test-lib: support running tests under valgrind in parallel
 - test-lib: allow prefixing a custom string before "ok N" etc.
 - test-lib: valgrind for only tests matching a pattern
 - test-lib: verbose mode for only tests matching a pattern
 - test-lib: refactor $GIT_SKIP_TESTS matching
 - test-lib: enable MALLOC_* for the actual tests

 Allows N instances of tests run in parallel, each running 1/N parts
 of the test suite under Valgrind, to speed things up.

 The tip one may be useful in practice but is a tad ugly ;-)

 There seem to be some miscounting by toggling the verbose/valgrind
 mode at wrong places?  Cf. $gmane/225735

 Waiting for a reroll.


* fc/contrib-related (2013-06-09) 5 commits
 - contrib: related: print the amount of involvement
 - contrib: related: parse committish like format-patch
 - contrib: related: add option to parse from committish
 - contrib: related: add support for multiple patches
 - Add new git-related helper to contrib


* hv/config-from-blob (2013-05-12) 5 commits
 - do not die when error in config parsing of buf occurs
 - teach config --blob option to parse config from database
 - config: make parsing stack struct independent from actual data source
 - config: drop cf validity check in get_next_char()
 - config: factor out config file stack management

 Waiting for a reroll.
 $gmane/223964


* mm/color-auto-default (2013-06-10) 2 commits
  (merged to 'next' on 2013-06-14 at 0647576)
 + make color.ui default to 'auto'
 + config: refactor management of color.ui's default value

 Flip the default for color.ui to 'auto', which is what many
 tutorials recommend new users to do.

 Will merge to 'master'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-04-03) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.

--------------------------------------------------
[Discarded]

* rr/complete-difftool (2013-06-09) 3 commits
  (merged to 'next' on 2013-06-09 at 2ee40cb)
 + Revert 77c1305 and 3c3b46b
  (merged to 'next' on 2013-06-07 at 90e5f58)
 + completion: add deprecated __git_complete_file ()
  (merged to 'next' on 2013-06-04 at 01c7611)
 + completion: clarify ls-tree, archive, show completion

 Update command line completion (in contrib/) to use a better named
 completion helper function for commands that take revisions and
 paths.

 Reverted, to be replaced with rr/complete-difftool-fixup.


* fc/remote-helpers-use-specified-python (2013-05-28) 4 commits
 - remote-helpers: add exec-path links
 - remote-helpers: allow direct test execution
 - remote-helpers: rename tests
 - remote-helpers: generate scripts

 Retracted.
