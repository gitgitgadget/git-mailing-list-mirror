From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2010, #01; Wed, 03)
Date: Wed, 03 Feb 2010 22:28:59 -0800
Message-ID: <7vtytxo6ok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 07:29:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcvDG-0000ro-9d
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 07:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab0BDG3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 01:29:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab0BDG3G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 01:29:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A8979692B;
	Thu,  4 Feb 2010 01:29:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=pk0z
	IA5mzfWUYiu8ofYR2PiBwZ4=; b=AGOBEFS2xEUXA/zzl9KxNB0FSJfrDuMMdBMF
	5hr3bKrN4u+b5RQ18hpP/EBj9BMDrOHak97hSDlJeo16XWu6qKkYgjzpM/MZ2RmK
	y/zU8Xdg8OFMXHwfk8Y18KKRD4E2KpXiXnC5xGKzPZUr2WS+fj7gDlHkwfabfE3r
	8oP9Zco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=d2y
	m2tnmbUMe74NOAk1JWO/0/ILTEBbLZppdrDSYqqD0HF37HJR1/cVykc/6pMvhIBU
	kiXp55ATRZuoMJGaWueKYJ97WpMbMXcjoFflDbL3h0gwHTRQIxQOgaiYVXA5GI+L
	AHKoXecuP64rX7jqf7eI1Mf/1/Yx1zB8KFElzpqU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 082AB9692A;
	Thu,  4 Feb 2010 01:29:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A44796928; Thu,  4 Feb
 2010 01:29:01 -0500 (EST)
X-master-at: 07cf0f2407709e3764ea989696b513ec32613504
X-next-at: 9253ab096ff0b88d2d690152c03d9e2491d5c40c
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 964005F4-1156-11DF-9087-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138953>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

We are passed 1.7.0-rc1; please test "master" branch to avoid giving
regressions to end users.  Thanks.

--------------------------------------------------
[Graduated to "master"]

* bw/no-python-autoconf (2010-01-31) 2 commits
  (merged to 'next' on 2010-02-01 at 7c70402)
 + configure: Allow --without-python
 + configure: Allow GIT_ARG_SET_PATH to handle --without-PROGRAM

* ms/filter-branch-submodule (2010-01-28) 2 commits
  (merged to 'next' on 2010-01-28 at 226cbf8)
 + filter-branch: Add tests for submodules in tree-filter
 + filter-branch: Fix to allow replacing submodules with another content

* sp/maint-fast-import-large-blob (2010-02-01) 1 commit
  (merged to 'next' on 2010-02-01 at 04d206f)
 + fast-import: Stream very large blobs directly to pack
 (this branch is used by sp/fast-import-large-blob.)

Importing a large blob via fast-import may bust the pack size limit (or
2GB filesize limit found on some filesystems).

* sp/fast-import-large-blob (2010-02-01) 0 commits
 (this branch uses sp/maint-fast-import-large-blob.)

And this is to help merging the topic to newer codebase.

--------------------------------------------------
[New Topics]

* jc/typo (2010-02-03) 1 commit
 - Typofixes outside documentation area

--------------------------------------------------
[Cooking]

* jn/maint-makedepend (2010-01-26) 5 commits
 - Makefile: drop dependency on $(wildcard */*.h)
 - Makefile: clean up http-walker.o dependency rules
 - Makefile: remove wt-status.h from LIB_H
 - Makefile: make sure test helpers are rebuilt when headers change
 - Makefile: add missing header file dependencies
 (this branch is used by jn/makedepend and jn/master-makedepend.)

These look sensible clean-up that could go to maint later.

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

And this is to build on top.  I don't want to touch build infrastructure
during the pre-release freeze too much to avoid the last minute hassles
that is only discovered when I try to cut RPMs; hence this will stay out
of 'master' until 1.7.0 ships.

* jc/checkout-detached (2010-01-29) 1 commit
 - Reword "detached HEAD" notification

* jc/maint-fix-test-perm (2010-01-30) 2 commits
 - lib-patch-mode.sh: Fix permission
 - t6000lib: Fix permission

* jh/gitweb-caching (2010-01-30) 1 commit
 - gitweb: Add an option to force version match

* jn/makefile-script-lib (2010-01-31) 1 commit
 - Do not install shell libraries executable

* mv/request-pull-modernize (2010-01-29) 1 commit
 - request-pull: avoid mentioning that the start point is a single commit

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
