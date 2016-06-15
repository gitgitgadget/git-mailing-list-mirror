From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2013, #04; Tue, 11)
Date: Tue, 11 Jun 2013 15:34:32 -0700
Message-ID: <7vwqq05laf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 00:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmX9G-0000qA-Ie
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 00:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378Ab3FKWei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 18:34:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756291Ab3FKWef convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 18:34:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CD8627F2E;
	Tue, 11 Jun 2013 22:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=mt4BEb9hvp2aEWkw3Mf4VAlOR
	pE=; b=X1MIW0MMWFy/qVA37/kvBI/X+uLth3jeS5Xt2i832t5yfwG56mRX3T23t
	YuHcNTR8vjyuwPH2SgoIg0Izhm0+yutqINvu1JoLHbUUyHyxf2cDjMynUjNdcj4Y
	SCZX7L0Ky2B2zAVKo0EyN6Y2/bAqTLs3OD5htU9TY0zbEOCs34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=T1YepKfMrmzJS8W0r78
	/ExSkZMldodWFQ7FBni8f+u0dXvifV9vQ2cQgyXin7TCWqX/M+CYm5jU2KlOiR/y
	vHDtYg/U5O1ynomhNDWYezAVhjRPYUbtMdz66+PyIEiXeVn4Z/Umu8EFOxtt/J7a
	L8zKxc2eHVfYDfFiKhnf+Jkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3155227F2D;
	Tue, 11 Jun 2013 22:34:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5FAF27F2B;
	Tue, 11 Jun 2013 22:34:33 +0000 (UTC)
X-master-at: 4d1c565e1fb4e76c391448cdf85fe7c132bbb390
X-next-at: 3b07823faafc941f5079443779265b5ba32c8407
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16FD512E-D2E7-11E2-935C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227571>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ar/wildmatch-foldcase (2013-06-02) 1 commit
  (merged to 'next' on 2013-06-04 at 3180bcc)
 + wildmatch: properly fold case everywhere

 The wildmatch engine did not honor WM_CASEFOLD option correctly.


* cb/log-follow-with-combined (2013-05-28) 1 commit
  (merged to 'next' on 2013-06-04 at d5bf4f3)
 + fix segfault with git log -c --follow


* cm/gitweb-project-list-persistent-cgi-fix (2013-06-07) 1 commit
  (merged to 'next' on 2013-06-07 at b16ca1f)
 + gitweb: fix problem causing erroneous project list

 "gitweb" forgot to clear a global variable $search_regexp upon each
 request, mistakenly carrying over the previous search to a new one
 when used as a persistent CGI.


* cr/git-work-tree-sans-git-dir (2013-06-03) 1 commit
  (merged to 'next' on 2013-06-04 at bebedca)
 + git.txt: remove stale comment regarding GIT_WORK_TREE

 These days, "git --work-tree=3Dthere cmd" without specifying an
 explicit --git-dir=3Dhere will do the usual discovery, but we had a
 description of older behaviour in the documentation.


* fc/at-head (2013-05-08) 13 commits
  (merged to 'next' on 2013-06-04 at f334a2a)
 + sha1_name: compare variable with constant, not constant with variabl=
e
 + Add new @ shortcut for HEAD
 + sha1_name: refactor reinterpret()
 + sha1_name: check @{-N} errors sooner
 + sha1_name: reorganize get_sha1_basic()
 + sha1_name: don't waste cycles in the @-parsing loop
 + sha1_name: remove unnecessary braces
 + sha1_name: remove no-op
 + tests: at-combinations: @{N} versus HEAD@{N}
 + tests: at-combinations: increase coverage
 + tests: at-combinations: improve nonsense()
 + tests: at-combinations: check ref names directly
 + tests: at-combinations: simplify setup

 Instead of typing four capital letters "HEAD", you can say "@".


* fc/completion-less-ls-remote (2013-06-02) 1 commit
  (merged to 'next' on 2013-06-03 at 6624f0b)
 + completion: avoid ls-remote in certain scenarios


* fc/do-not-use-the-index-in-add-to-index (2013-06-03) 2 commits
  (merged to 'next' on 2013-06-04 at 94e7b60)
 + read-cache: trivial style cleanups
 + read-cache: fix wrong 'the_index' usage


* fc/remote-bzr (2013-05-28) 8 commits
  (merged to 'next' on 2013-06-04 at a603082)
 + remote-bzr: add fallback check for a partial clone
 + remote-bzr: reorganize the way 'wanted' works
 + remote-bzr: trivial cleanups
 + remote-bzr: change global repo
 + remote-bzr: delay cloning/pulling
 + remote-bzr: simplify get_remote_branch()
 + remote-bzr: fix for files with spaces
 + remote-bzr: recover from failed clones


* fc/remote-hg (2013-05-28) 50 commits
  (merged to 'next' on 2013-06-04 at 9ee7dab)
 + remote-hg: add support for --force
 + remote-hg: add support for --dry-run
 + remote-hg: check if a fetch is needed
 + remote-hg: trivial cleanup
 + remote-helpers: improve marks usage
 + remote-hg: add check_push() helper
 + remote-hg: add setup_big_push() helper
 + remote-hg: remove files before modifications
 + remote-hg: improve lightweight tag author
 + remote-hg: use remote 'default' not local one
 + remote-hg: improve branch listing
 + remote-hg: simplify branch_tip()
 + remote-hg: check diverged bookmarks
 + remote-hg: pass around revision refs
 + remote-hg: implement custom checkheads()
 + remote-hg: implement custom push()
 + remote-hg: only update necessary revisions
 + remote-hg: force remote bookmark push selectively
 + remote-hg: reorganize bookmark handling
 + remote-hg: add test for failed double push
 + remote-hg: add test for big push
 + remote-hg: add test for new bookmark special
 + remote-hg: add test for bookmark diverge
 + remote-hg: add test for diverged push
 + remote-hg: add test to push new bookmark
 + remote-hg: add remote tests
 + remote-hg: update bookmarks when using a remote
 + remote-hg: add check_bookmark() test helper
 + remote-bzr: simplify test checks
 + remote-hg: add tests for 'master' bookmark
 + remote-hg: always point HEAD to master
 + remote-hg: improve progress calculation
 + remote-hg: trivial cleanups
 + remote-hg: ensure remote rebasing works
 + remote-hg: upgrade version 1 marks
 + remote-hg: switch from revisions to SHA-1 noteids
 + remote-hg: add version checks to the marks
 + remote-hg: improve node traversing
 + remote-hg: shuffle some code
 + remote-hg: use a shared repository store
 + remote-hg: load all extensions
 + remote-hg: test: simplify previous branch checkout
 + remote-helpers: test: simplify remote URLs
 + remote-helpers: tests: general improvements
 + remote-helpers: test: cleanup style
 + remote-helpers: test: cleanup white-spaces
 + remote-hg: trivial reorganization
 + remote-hg: test: be a little more quiet
 + remote-hg: tests: fix hg merge
 + remote-helpers: tests: use python directly


* jk/test-exit-code-by-signal (2013-06-06) 2 commits
  (merged to 'next' on 2013-06-06 at 6fdea1b)
 + t0005: skip signal death exit code test on Windows
  (merged to 'next' on 2013-06-03 at 25af892)
 + t0005: test git exit code from signal death


* mm/mediawiki-https-fail-message (2013-05-29) 1 commit
  (merged to 'next' on 2013-06-04 at fb2671c)
 + git-remote-mediawiki: better error message when HTTP(S) access fails

 Hint users when https:// connection failed to check the
 certificate; it is a good hint if we assumie that it is common
 error for the end users to make.


* nd/warn-ambiguous-object-name (2013-05-29) 1 commit
  (merged to 'next' on 2013-06-04 at e87c9d1)
 + get_sha1: warn about full or short object names that look like refs

 "git cmd <name>", when <name> happens to be a 40-hex string,
 directly uses the 40-hex string as an object name, even if a ref
 "refs/<some hierarchy>/<name>" exists.  This disambiguation order
 is unlikely to change, but we should warn about the ambiguity just
 like we warn when more than one refs/ hierachies share the same
 name.


* rj/mingw-cygwin (2013-05-08) 2 commits
  (merged to 'next' on 2013-06-04 at 308fdb4)
 + cygwin: Remove the CYGWIN_V15_WIN32API build variable
 + mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE

 Update build for Cygwin 1.[57].  Torsten B=C3=B6gershausen reports tha=
t
 this is fine with Cygwin 1.7 ($gmane/225824) so let's try moving it
 ahead.


* rr/die-on-missing-upstream (2013-06-02) 2 commits
  (merged to 'next' on 2013-06-03 at 00847ea)
 + sha1_name: fix error message for @{<N>}, @{<date>}
 + sha1_name: fix error message for @{u}

 When a reflog notation is used for implicit "current branch", we
 did not say which branch and worse said "branch ''".


* rr/diffcore-pickaxe-doc (2013-06-03) 2 commits
  (merged to 'next' on 2013-06-04 at 67d1fc7)
 + diffcore-pickaxe doc: document -S and -G properly
 + diffcore-pickaxe: make error messages more consistent

 Update the low-level diffcore documentation on -S/-G and --pickaxe-all=
=2E


* rr/maint-fetch-tag-doc-asterisks (2013-06-07) 1 commit
  (merged to 'next' on 2013-06-07 at bfa4e7b)
 + fetch-options.txt: prevent a wildcard refspec from getting misformat=
ted


* rr/rebase-autostash (2013-05-29) 7 commits
  (merged to 'next' on 2013-06-04 at 16f7c54)
 + rebase: implement --[no-]autostash and rebase.autostash
 + rebase --merge: return control to caller, for housekeeping
 + rebase -i: return control to caller, for housekeeping
 + am: return control to caller, for housekeeping
 + rebase: prepare to do generic housekeeping
 + rebase -i: don't error out if $state_dir already exists
 + am: tighten a conditional that checks for $dotest


* rs/unpack-trees-plug-leak (2013-06-02) 7 commits
  (merged to 'next' on 2013-06-03 at 97e7b6d)
 + unpack-trees: free cache_entry array members for merges
 + diff-lib, read-tree, unpack-trees: mark cache_entry array paramters =
const
 + diff-lib, read-tree, unpack-trees: mark cache_entry pointers const
 + unpack-trees: create working copy of merge entry in merged_entry
 + unpack-trees: factor out dup_entry
 + read-cache: mark cache_entry pointers const
 + cache: mark cache_entry pointers const


* tr/sha1-file-silence-loose-object-info-under-prune-race (2013-06-03) =
1 commit
  (merged to 'next' on 2013-06-04 at e891bb8)
 + sha1_file: silence sha1_loose_object_info


* tr/test-commit-only-on-orphan (2013-06-02) 1 commit
  (merged to 'next' on 2013-06-03 at b1864fd)
 + Test 'commit --only' after 'checkout --orphan'


* xq/credential-osxkeychain (2013-05-28) 1 commit
  (merged to 'next' on 2013-06-04 at a4ee0e0)
 + credential-osxkeychain: support more protocols

--------------------------------------------------
[New Topics]

* jc/topo-author-date-sort (2013-06-11) 4 commits
 - log: --author-date-order
 - sort-in-topological-order: use prio-queue
 - prio-queue: priority queue of pointers to structs
 - toposort: rename "lifo" field
 (this branch uses jk/commit-info-slab; is tangled with jc/show-branch.=
)

 "git log" learned the "--author-date-order" option, with which the
 output is topologically sorted and commits in parallel histories
 are shown intermixed together based on the author timestamp.

 Will merge to 'next'.


* fc/makefile (2013-06-09) 4 commits
 - Makefile: use $^ to avoid listing prerequisites on the command line
 - build: do not install git-remote-testgit
 - build: generate and clean test scripts
 - Merge branch 'js/transport-helper-error-reporting-fix' into fc/makef=
ile

 Will merge to 'next'.


* fc/show-non-empty-errors-in-test (2013-06-09) 1 commit
 - test: test_must_be_empty helper

 Will merge to 'next'.


* nd/traces (2013-06-09) 2 commits
 - git.txt: document GIT_TRACE_PACKET
 - core: use env variable instead of config var to turn on logging pack=
 access

 Will merge to 'next'.


* rr/complete-difftool-fixup (2013-06-09) 2 commits
  (merged to 'next' on 2013-06-11 at fe91170)
 + completion: show can take both revlist and paths
 + completion: difftool takes both revs and files
 (this branch is tangled with rr/complete-difftool.)

 Replaces rr/complete-difftool.

 Will merge to 'master'.


* rr/triangle-push-fix (2013-06-09) 4 commits
 - t/push-default: test pushdefault with all modes
 - t/push-default: generalize test_push_{success, commit}
 - push: make upstream, simple work with pushdefault
 - t/push-default: remove redundant test_config lines

 Tries to apply the 'push.default =3D upstream' semantics to
 triangular workflow where it does not quite apply.

 Will be worked further.


* rs/discard-index-discard-array (2013-06-09) 2 commits
 - read-cache: free cache in discard_index
 - read-cache: add simple performance test

 Will merge to 'next'.


* cm/remote-mediawiki (2013-06-11) 1 commit
 - git-remote-mediawiki: display message when launched directly

 Will merge to 'next'.


* jg/status-config (2013-06-11) 2 commits
 - status:introduce status.branch to enable --branch by default
 - status: introduce status.short to enable --short by default

 Will merge to 'next'.


* mh/loose-refs-race-with-pack-ref (2013-06-11) 4 commits
 - resolve_ref_unsafe(): close race condition reading loose refs
 - resolve_ref_unsafe(): nest reference-reading code in an infinite loo=
p
 - resolve_ref_unsafe(): handle the case of an SHA-1 within loop
 - resolve_ref_unsafe(): extract function handle_missing_loose_ref()

--------------------------------------------------
[Stalled]

* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD t=
o origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin=
/HEAD"
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
 - rm: delete .gitmodules entry of submodules removed from the work tre=
e
 - Teach mv to update the path entry in .gitmodules for moved submodule=
s
 - Teach mv to move submodules using a gitfile
 - Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Waiting for a reroll.


* jk/list-objects-sans-blobs (2013-06-06) 4 commits
 . archive: ignore blob objects when checking reachability
 . list-objects: optimize "revs->blob_objects =3D 0" case
 . upload-archive: restrict remote objects with reachability check
 . clear parsed flag when we free tree buffers

 Attempt to allow "archive --remote=3D$there $arbitrary_sha1" while
 keeping the reachability safety.

 Seems to break some tests in a trivial and obvious way.


* fc/remote-helpers-use-specified-python (2013-05-28) 4 commits
 - remote-helpers: add exec-path links
 - remote-helpers: allow direct test execution
 - remote-helpers: rename tests
 - remote-helpers: generate scripts

 I do not particularly think the second from the bottom is a good
 change, but it takes the remainder of the series hostage.

 Waiting for a reroll.


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
 - gitweb: Don't append ';js=3D(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff=
_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary widt=
h
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style
 (this branch uses jk/commit-info-slab; is tangled with jc/topo-author-=
date-sort.)

 Waiting for the final step to lift the hard-limit before sending it ou=
t.

--------------------------------------------------
[Cooking]

* jk/commit-info-slab (2013-06-07) 3 commits
 - commit-slab: introduce a macro to define a slab for new type
 - commit-slab: avoid large realloc
 - commit: allow associating auxiliary info on-demand
 (this branch is used by jc/show-branch and jc/topo-author-date-sort.)

 Technology demonstration to show a way we could add custom
 information to represent unbound number of flag bits etc. to commit
 objects.

 Will be in 'next' with jc/topo-author-date-sort.


* fc/sequencer-skip-quiet (2013-06-06) 5 commits
 - sequencer: run post-rewrite hook
 - cherry-pick: store rewritten commits
 - cherry-pick: add --skip-empty option
 - sequencer: avoid leaking message buffer when refusing to create an e=
mpty commit
 - sequencer: remove useless indentation

 The bottom three looked more or less reasonable.  Execution of
 post-rewrite hook could use a better refactoring from the original
 code copied from builtin/commit.c, though.

 Will discard the top 3, merge the rest to 'next'.


* js/test-ln-s-add (2013-06-07) 10 commits
 - t4011: remove SYMLINKS prerequisite
 - t6035: use test_ln_s_add to remove SYMLINKS prerequisite
 - t3509, t4023, t4114: use test_ln_s_add to remove SYMLINKS prerequisi=
te
 - t3100: use test_ln_s_add to remove SYMLINKS prerequisite
 - t3030: use test_ln_s_add to remove SYMLINKS prerequisite
 - t0000: use test_ln_s_add to remove SYMLINKS prerequisite
 - tests: use test_ln_s_add to remove SYMLINKS prerequisite (trivial ca=
ses)
 - tests: introduce test_ln_s_add
 - t3010: modernize style
 - test-chmtime: Fix exit code on Windows

 Many tests that check the behaviour of symbolic links stored in the
 index or the tree objects do not have to be skipped on a filesystem
 that lack symbolic link support.

 Will merge to 'next'.


* mt/send-email-cc-match-fix (2013-06-05) 7 commits
  (merged to 'next' on 2013-06-06 at e4d0831)
 + test-send-email: test for pre-sanitized self name
 + t/send-email: test suppress-cc=3Dself with non-ascii
 + t/send-email: add test with quoted sender
 + send-email: make --suppress-cc=3Dself sanitize input
 + t/send-email: test suppress-cc=3Dself on cccmd
 + send-email: fix suppress-cc=3Dself on cccmd
 + t/send-email.sh: add test for suppress-cc=3Dself

 Logic git-send-email used to suppress cc mishandled names like "A
 U. Thor" <author@example.xz>, where the human readable part needs
 to be quoted (the user input may not have the double quotes around
 the name, and comparison was done between quoted and unquoted
 strings).

 Will merge to 'master'.


* rr/complete-difftool (2013-06-09) 4 commits
  (merged to 'next' on 2013-06-09 at 2ee40cb)
 + Revert 77c1305 and 3c3b46b
  (merged to 'next' on 2013-06-07 at 90e5f58)
 + completion: add deprecated __git_complete_file ()
  (merged to 'next' on 2013-06-04 at 01c7611)
 + completion: clarify ls-tree, archive, show completion
 + completion: difftool takes both revs and files
 (this branch is tangled with rr/complete-difftool-fixup.)

 Update command line completion (in contrib/) to use a better named
 completion helper function for commands that take revisions and
 paths.

 Reverted, to be replaced with rr/complete-difftool-fixup.


* bp/mediawiki-credential (2013-06-05) 1 commit
  (merged to 'next' on 2013-06-05 at ea07ec1)
 + git-remote-mediawiki: use Git.pm functions for credentials

 The bridge to MediaWiki has been updated to use the credential
 helper interface in Git.pm, losing its own and the original
 implementation the former was based on.

 Will merge to 'master'.


* mz/rebase-tests (2013-06-07) 7 commits
 - tests: move test for rebase messages from t3400 to t3406
 - t3406: modernize style
 - add tests for rebasing merged history
 - add tests for rebasing root
 - add tests for rebasing of empty commits
 - add tests for rebasing with patch-equivalence present
 - add simple tests of consistency across rebase types

 Will merge to 'next'.


* nd/make-wildmatch-default (2013-06-02) 1 commit
 - Makefile: promote wildmatch to be the default fnmatch implementation

 Will merge to 'next'.


* rr/remove-contrib-some (2013-06-02) 1 commit
  (merged to 'next' on 2013-06-05 at fc15705)
 + contrib: remove continuous/ and patches/

 Remove stale contrib/ material.

 Will merge to 'master'.


* ap/diff-ignore-blank-lines (2013-06-10) 1 commit
 - diff: add --ignore-blank-lines option

 "git diff" learned a mode that ignores hunks whose change consists
 only of additions and removals of blank lines, which is the same as
 "diff -B" (ignore blank lines) of GNU diff.


* mh/reflife (2013-06-02) 25 commits
  (merged to 'next' on 2013-06-05 at 291d863)
 + refs: document the lifetime of the args passed to each_ref_fn
 + register_ref(): make a copy of the bad reference SHA-1
 + exclude_existing(): set existing_refs.strdup_strings
 + string_list_add_refs_by_glob(): add a comment about memory managemen=
t
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
 + revision: use object_array_filter() in implementation of gc_boundary=
()
 + object_array: add function object_array_filter()
 + revision: split some overly-long lines
 + cmd_diff(): make it obvious which cases are exclusive of each other
 + cmd_diff(): rename local variable "list" -> "entry"
 + cmd_diff(): use an object_array for holding trees
 + builtin_diff_tree(): make it obvious that function wants two entries
 + add_rev_cmdline(): make a copy of the name argument
 + fetch: make own copies of refnames
 + describe: make own copy of refname

 Define memory ownership and lifetime rules for what for-each-ref
 feeds to its callbacks (in short, "you do not own it, so make a
 copy if you want to keep it").

 Will merge to 'master'.


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
 - config: make parsing stack struct independent from actual data sourc=
e
 - config: drop cf validity check in get_next_char()
 - config: factor out config file stack management

 Waiting for a reroll.
 $gmane/223964


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

 Will merge to 'master'.


* mm/color-auto-default (2013-06-10) 2 commits
 - make color.ui default to 'auto'
 - config: refactor management of color.ui's default value

 Flip the default for color.ui to 'auto', which is what many
 tutorials recommend new users to do.

 Will merge to 'next'.


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
