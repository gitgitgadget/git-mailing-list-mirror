From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2010, #07; Fri, 22)
Date: Fri, 22 Jan 2010 19:28:21 -0800
Message-ID: <7vtyudfqju.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 04:28:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYWfo-0004IP-JO
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 04:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab0AWD22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 22:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887Ab0AWD21
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 22:28:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab0AWD20 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 22:28:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92E1393EA9;
	Fri, 22 Jan 2010 22:28:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=KWdv
	ZaJ5Fnhxs0fhkKsJVTfBtDs=; b=ky1NpN7nlLhWuTarFdk/QzZ4ei2G95Pc/74u
	fuhBnpyIxnwP8LGoOoA3OUkmCgcpFzwV6M+YnTGKA5KODqp5/u8S4Tmn+/5zKqIe
	BdfaXRiHUXqHx1aF2u8YKH1NriCF6UQedy0pKXcRcykldb0mckCbd9xhygxbYnhi
	sqEKLCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=tLw
	+e2YTKd8BUFe6AiFTgbzMXGsr3lIGdY0uYfbnw5fj+lCGtNcvnBn8WQwipcNldJs
	HslnY9OFtWaivjCUB/vZBzlsy36uUK9a8Yt7AuEX+2puHgpqC8AtEegfEtOGftfP
	sW+6L0uNRhMxAhd57uY7OGqm114fygmHYiNo0egI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8157693EA8;
	Fri, 22 Jan 2010 22:28:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BE1D93EA7; Fri, 22 Jan
 2010 22:28:22 -0500 (EST)
X-master-at: aba7dea83bfba411dee0271491d6199d2dca61d9
X-next-at: 7703121a442f8cf559a50f3a47b313dd77b8e185
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5D0AB954-07CF-11DF-B6EF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137808>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* jc/conflict-marker-size (2010-01-16) 8 commits
  (merged to 'next' on 2010-01-18 at f1f6023)
 + rerere: honor conflict-marker-size attribute
 + rerere: prepare for customizable conflict marker length
 + conflict-marker-size: new attribute
 + rerere: use ll_merge() instead of using xdl_merge()
 + merge-tree: use ll_merge() not xdl_merge()
 + xdl_merge(): allow passing down marker_size in xmparam_t
 + xdl_merge(): introduce xmparam_t for merge specific parameters
 + git_attr(): fix function signature

* ag/maint-apply-too-large-p (2010-01-17) 1 commit
  (merged to 'next' on 2010-01-18 at 8bd106a)
 + builtin-apply.c: Skip filenames without enough components

* ag/patch-header-verify (2010-01-18) 1 commit
  (merged to 'next' on 2010-01-18 at 2cd0ddc)
 + builtin-apply.c: fix the --- and +++ header filename consistency check

* bw/cvsimport (2010-01-19) 3 commits
  (merged to 'next' on 2010-01-19 at 63f4c8d)
 + cvsimport: standarize system() calls to external git tools
 + cvsimport: standarize open() calls to external git tools
 + cvsimport: modernize callouts to git subcommands

* jc/checkout-merge-base (2010-01-19) 1 commit
  (merged to 'next' on 2010-01-19 at 3665110)
 + Fix "checkout A..." synonym for "checkout A...HEAD" on Windows

* jc/maint-refresh-index-is-optional-for-status (2010-01-19) 1 commit
 + status: don't require the repository to be writable

* nd/status-partial-refresh (2010-01-17) 2 commits
  (merged to 'next' on 2010-01-19 at 64f0c0b)
 + rm: only refresh entries that we may touch
  (merged to 'next' on 2010-01-16 at f77bc8f)
 + status: only touch path we may need to check

* ap/merge-backend-opts (2008-07-18) 7 commits
  (merged to 'next' on 2010-01-18 at cb1f6b7)
 + Document that merge strategies can now take their own options
 + Extend merge-subtree tests to test -Xsubtree=dir.
 + Make "subtree" part more orthogonal to the rest of merge-recursive.
 + pull: Fix parsing of -X<option>
 + Teach git-pull to pass -X<option> to git-merge
 + git merge -X<option>
 + git-merge-file --ours, --theirs

* jc/maint-limit-note-output (2010-01-21) 2 commits
  (merged to 'next' on 2010-01-21 at bcb80b9)
 + Fix "log --oneline" not to show notes
  (merged to 'next' on 2010-01-20 at 526bfcc)
 + Fix "log" family not to be too agressive about showing notes

* nd/ls-files-sparse-fix (2010-01-20) 1 commit
  (merged to 'next' on 2010-01-20 at 0f61dbc)
 + Fix memory corruption when .gitignore does not end by \n

* il/branch-set-upstream (2010-01-18) 2 commits
  (merged to 'next' on 2010-01-18 at b9b0993)
 + branch: warn and refuse to set a branch as a tracking branch of itself.
 + Add branch --set-upstream

* il/remote-updates (2010-01-18) 1 commit
  (merged to 'next' on 2010-01-18 at 5c3e805)
 + Add git remote set-url

* il/rev-glob (2010-01-22) 3 commits
  (merged to 'next' on 2010-01-21 at 453a21c)
 + Documentation: improve description of --glob=pattern and friends
  (merged to 'next' on 2010-01-20 at 928ba0a)
 + rev-parse --branches/--tags/--remotes=pattern
 + rev-parse --glob

This is a re-rolled "--namespace=" one.

* jl/submodule-diff (2010-01-18) 4 commits
  (merged to 'next' on 2010-01-20 at 95cb513)
 + Performance optimization for detection of modified submodules
  (merged to 'next' on 2010-01-17 at 525075b)
 + git status: Show uncommitted submodule changes too when enabled
  (merged to 'next' on 2010-01-16 at 0a99e3c)
 + Teach diff that modified submodule directory is dirty
 + Show submodules as modified when they contain a dirty work tree

* js/refer-upstream (2010-01-19) 3 commits
  (merged to 'next' on 2010-01-20 at 5a5547a)
 + Teach @{upstream} syntax to strbuf_branchanme()
 + t1506: more test for @{upstream} syntax
 + Introduce <branch>@{upstream} notation

Updated to teach the new syntax to commands like "checkout" and "merge"
that want to behave better when they know what were given was a branch
name, not a random SHA-1.

* jc/branch-d (2009-12-29) 1 commit
  (merged to 'next' on 2010-01-10 at 61a14b7)
 + branch -d: base the "already-merged" safety on the branch it merges with

--------------------------------------------------
[Will merge to 'master' after a bit more cooking in 'next']

* jc/fix-tree-walk (2009-09-14) 7 commits
  (merged to 'next' on 2010-01-13 at 1c01b87)
 + read-tree --debug-unpack
 + unpack-trees.c: look ahead in the index
 + unpack-trees.c: prepare for looking ahead in the index
 + Aggressive three-way merge: fix D/F case
 + traverse_trees(): handle D/F conflict case sanely
 + more D/F conflict tests
 + tests: move convenience regexp to match object names to test-lib.sh

Resurrected from "Ejected" category.  This is fix for a tricky codepath
and testing and improving before it hits 'master' is greatly appreciated.
(I have been using this in my private build for some time).

--------------------------------------------------
[Cooking]

* jh/notes (2010-01-17) 20 commits
 . builtin-gc: Teach the new --notes option to garbage-collect notes
 . Notes API: gc_notes(): Prune notes that belong to non-existing objects
 . t3305: Verify that removing notes triggers automatic fanout consolidation
 . builtin-notes: Teach -d option for deleting existing notes
 . Teach builtin-notes to remove empty notes
 . Teach notes code to properly preserve non-notes in the notes tree
 . t3305: Verify that adding many notes with git-notes triggers increased fanout
 . t3301: Verify successful annotation of non-commits
 . Builtin-ify git-notes
 . Refactor notes concatenation into a flexible interface for combining notes
 . Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 . Notes API: write_notes_tree(): Store the notes tree in the database
 . Notes API: for_each_note(): Traverse the entire notes tree with a callback
 . Notes API: get_note(): Return the note annotating the given object
 . Notes API: remove_note(): Remove note objects from the notes tree structure
 . Notes API: add_note(): Add note objects to the internal notes tree structure
 . Notes API: init_notes(): Initialize the notes tree from the given notes ref
 . Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
 . Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 . Minor non-functional fixes to notes.c

Tentatively ejected, as its tests conflict with tests in a higher priority
fix.

* jh/gitweb-cached (2010-01-13) 9 commits
 - gitweb: File based caching layer (from git.kernel.org)
 - gitweb: Convert output to using indirect file handle
 - gitweb: cleanup error message produced by undefined $site_header
 - gitweb: add a get function to compliment print_sort_th
 - gitweb: add a get function to compliment print_local_time
 - gitweb: Makefile improvements
 - gitweb: Add option to force version match
 - gitweb: change die_error to take "extra" argument for extended die information
 - gitweb: Load checking

Replaced with a re-roll.  Update to t9500 is probably needed.

* jc/grep-author-all-match-implicit (2010-01-17) 1 commit
 - "log --author=me --grep=it" should find intersection, not union
