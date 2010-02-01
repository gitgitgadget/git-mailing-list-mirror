From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2010, #10; Sun, 31)
Date: Sun, 31 Jan 2010 19:35:08 -0800
Message-ID: <7v4om1d3wz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 04:35:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbn4S-00026L-3D
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 04:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab0BADfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 22:35:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab0BADfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 22:35:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DCBE096F2A;
	Sun, 31 Jan 2010 22:35:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=BBDQ
	00SmZB4fRhPioL9A6j0rCvQ=; b=K1h/TLgvb3MSqyCMm79GkguSUvwD6AyHKqHB
	zQ1oQQLwfFPnz+CCFiHvp6+dmHLzWNGbF0NXFxDPiZafbFV+0oqPUxDa74AJVl4Q
	98RKlv5f36beHkXA4HwOezIfNC2myYu+zOt3pubXAjgAfRCmnzGYYmN1KHiNx9mY
	0CKuysM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=M/O
	paGAuFv2f2x6wpvNsuWCFWYHbu6MkptfEQ8ChrDSp3hL3ZggX+GUop/Jv59lj9G6
	jFToxkenPq+zjilfA07FrsqEFWrke9AqXFgO1uCIOheB1aVYUoPkxoWZi4shR+lM
	2uPAdoCmkwUwB2goUstAvrm+5zXL6/jNPL1QSfaE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C95A296F28;
	Sun, 31 Jan 2010 22:35:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA43496F27; Sun, 31 Jan
 2010 22:35:09 -0500 (EST)
X-master-at: c0da5db1e692c2bc74e5cdba67baf8762ac304b4
X-next-at: 0b0b75cec288f9895f99607456ed06b21da0e2a9
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD821D3E-0EE2-11DF-88D0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138577>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

We are passed 1.7.0-rc1; please test "master" branch to avoid giving
regressions to end users.  Thanks.

--------------------------------------------------
[Graduated to "master"]

* jl/diff-submodule-ignore (2010-01-24) 2 commits
  (merged to 'next' on 2010-01-25 at fbe713d)
 + Teach diff --submodule that modified submodule directory is dirty
 + git diff: Don't test submodule dirtiness with --ignore-submodules
 (this branch uses jc/ce-uptodate.)

* jc/ce-uptodate (2010-01-24) 1 commit
  (merged to 'next' on 2010-01-25 at fbe713d)
 + Make ce_uptodate() trustworthy again
 (this branch is used by jl/diff-submodule-ignore.)

* gp/maint-cvsserver (2010-01-26) 1 commit
 + git-cvsserver: allow regex metacharacters in CVSROOT

* fk/threaded-grep (2010-01-25) 1 commit
  (merged to 'next' on 2010-01-26 at 687b2a6)
 + Threaded grep
 (this branch uses jc/grep-q.)

400% performance gain on a 4-core box ;-)

* jc/grep-q (2010-01-25) 1 commit
  (merged to 'next' on 2010-01-26 at 687b2a6)
 + grep: expose "status-only" feature via -q
 (this branch is used by fk/threaded-grep.)

--------------------------------------------------
[New Topics]

* jn/maint-makedepend (2010-01-26) 5 commits
 - Makefile: drop dependency on $(wildcard */*.h)
 - Makefile: clean up http-walker.o dependency rules
 - Makefile: remove wt-status.h from LIB_H
 - Makefile: make sure test helpers are rebuilt when headers change
 - Makefile: add missing header file dependencies
 (this branch is used by jn/makedepend and jn/master-makedepend.)

These look sensible clean-up that could go to maint.

* jn/master-makedepend (2010-01-26) 0 commits
 (this branch uses jn/maint-makedepend; is used by jn/makedepend.)

This is to help merging the clean-up to "master".

* jn/makedepend (2010-01-31) 9 commits
 - Makefile: always remove .depend directories on 'make clean'
 - Makefile: tuck away generated makefile fragments in .depend
 - Teach Makefile to check header dependencies
 - Makefile: list standalone program object files in PROGRAM_OBJS
 - Makefile: lazily compute header dependencies
 - Makefile: list generated object files in OBJECTS
 - Makefile: disable default implicit rules
 - Makefile: rearrange dependency rules
 - Makefile: transport.o depends on branch.h now
 (this branch uses jn/maint-makedepend and jn/master-makedepend.)

And this is to build on top.

* ms/filter-branch-submodule (2010-01-28) 2 commits
  (merged to 'next' on 2010-01-28 at 226cbf8)
 + filter-branch: Add tests for submodules in tree-filter
 + filter-branch: Fix to allow replacing submodules with another content

* jc/checkout-detached (2010-01-29) 1 commit
 - Reword "detached HEAD" notification

* jc/maint-fix-test-perm (2010-01-30) 2 commits
 - lib-patch-mode.sh: Fix permission
 - t6000lib: Fix permission

* jh/gitweb-caching (2010-01-30) 8 commits
 - gitweb: Add an option to force version match
 - gitweb: Add optional extra parameter to die_error, for extended explanation
 - gitweb: add a "string" variant of print_sort_th
 - gitweb: add a "string" variant of print_local_time
 - gitweb: Check that $site_header etc. are defined before using them
 - gitweb: Makefile improvements
 - gitweb: Load checking
 - gitweb: Make running t9501 test with '--debug' reliable and usable

* jn/makefile-script-lib (2010-01-31) 1 commit
 - Do not install shell libraries executable

* mv/request-pull-modernize (2010-01-29) 1 commit
 - request-pull: avoid mentioning that the start point is a single commit

* sp/maint-fast-import-large-blob (2010-01-29) 1 commit
 - fast-import: Stream very large blobs directly to pack
 (this branch is used by sp/fast-import-large-blob.)

Importing a large blob via fast-import may bust the pack size limit (or
2GB filesize limit found on some filesystems).

* sp/fast-import-large-blob (2010-01-29) 0 commits
 (this branch uses sp/maint-fast-import-large-blob.)

And this is to help merging the topic to newer codebase.

--------------------------------------------------
[Cooking]

* cc/reset-keep (2010-01-19) 5 commits
 - reset: disallow using --keep when there are unmerged entries
 - reset: disallow "reset --keep" outside a work tree
 - Documentation: reset: describe new "--keep" option
 - reset: add test cases for "--keep" option
 - reset: add option "--keep" to "git reset"

I do not think I'd ever use this, and I am not convinced I can sell this
to users as a great new feature without confusing them unnecessarily, but
perhaps queuing it to pu to give it wider visibility may help somebody
coming up with a better way to defend the feature and introduce it to
users without confusing them than Christan nor I managed to.

* jh/notes (2010-01-27) 23 commits
 - builtin-notes: Add "add" subcommand for appending to note objects
 - builtin-notes: Add "list" subcommand for listing note objects
 - Documentation: Generalize git-notes docs to 'objects' instead of 'commits'
 - builtin-notes: Add "prune" subcommand for removing notes for missing objects
 - Notes API: prune_notes(): Prune notes that belong to non-existing objects
 - t3305: Verify that removing notes triggers automatic fanout consolidation
 - builtin-notes: Add "remove" subcommand for removing existing notes
 - Teach builtin-notes to remove empty notes
 - Teach notes code to properly preserve non-notes in the notes tree
 - t3305: Verify that adding many notes with git-notes triggers increased fanout
 - t3301: Verify successful annotation of non-commits
 - Builtin-ify git-notes
 - Refactor notes concatenation into a flexible interface for combining notes
 - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 - Notes API: write_notes_tree(): Store the notes tree in the database
 - Notes API: for_each_note(): Traverse the entire notes tree with a callback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: remove_note(): Remove note objects from the notes tree structure
 - Notes API: add_note(): Add note objects to the internal notes tree structure
 - Notes API: init_notes(): Initialize the notes tree from the given notes ref
 - Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
 - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 - Cosmetic fixes to notes.c

* jc/grep-author-all-match-implicit (2010-01-17) 1 commit
 - "log --author=me --grep=it" should find intersection, not union
