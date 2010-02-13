From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2010, #03; Fri, 12)
Date: Fri, 12 Feb 2010 17:24:58 -0800
Message-ID: <7vfx566i6t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 02:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng6l0-00086R-Lm
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 02:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab0BMBZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 20:25:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab0BMBZE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 20:25:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2AD199DDA;
	Fri, 12 Feb 2010 20:25:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=wR2e
	KyC6djYimY8aDOna3CwZ/q4=; b=aqmwXCVvV2gi16qSlvYcwPNhUx5Lb2fFmPL8
	wrf1Kv0lP4WO8jpnIIxhMxqE7fL5foDkevFOMY72nGZYz+IuhdcvlwUA3TFbgKAS
	v9Lzo7sQYnHRWEt50HpzdYfR0q0nLNHeXJlA60ALIjCBZOReNLiCipMG/JmlyNIA
	y0eCFtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Uk/
	2w+FsWxt9YQC4wqwunyFZU7SFcEGoQmozD+Y6ZtMBzGtDxtsjdRWUakW4UXkzD5f
	N49yTH1bKyfUmQzAOyA4S+fiok29puLAe1Cd+o3jUCEMD1Gi5fH+XkCoFU8B/i80
	cRSpWt3yrwC5ULIHgJGtIuzDrOwxsXMQlFzxP5ok=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4CFC99DD9;
	Fri, 12 Feb 2010 20:25:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 932E799DD6; Fri, 12 Feb
 2010 20:25:00 -0500 (EST)
X-master-at: e923eaeb901ff056421b9007adcbbce271caa7b6
X-next-at: 57c9972634e181f6aad83258a8e7d61f0b99b6ce
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9BD6D576-183E-11DF-BE04-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139770>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

Now 1.7.0 is out, we will take a short pause and watch breakage reports
(or Olympics ;-) for a few days, and then start merging down new topics.

--------------------------------------------------
[New Topics]

* ld/push-porcelain (2010-02-09) 4 commits
 - git-push: fix an error message so it goes to stderr
 - git-push: make git push --dry-run --porcelain exit with status 0 even if updates will be rejected
 - git-push: send "To <remoteurl>" messages to the standard output in --porcelain mode
 - git-push: squelch advice message if in --porcelain mode

After some discussion this needs further simplification?

* cp/add-u-pathspec (2010-02-09) 2 commits
 - test for add with non-existent pathspec
 - git add -u: die on unmatched pathspec

* hm/maint-imap-send-crlf (2010-02-12) 1 commit
 - git-imap-send: Convert LF to CRLF before storing patch to draft box

Cram-MD5 from the same author seemed to need another round before landing
here, but this one seemed to be ready for 'pu'.

* jk/cherry-pick-reword (2010-02-11) 5 commits
  (merged to 'next' on 2010-02-11 at d0eace1)
 + cherry-pick: prettify the advice message
 + cherry-pick: show commit name instead of sha1
 + cherry-pick: format help message as strbuf
 + cherry-pick: refactor commit parsing code
 + cherry-pick: rewrap advice message

* nd/root-git (2010-02-11) 5 commits
 - Add test for using Git at root directory
 - Support working directory located at root
 - Add is_root_path()
 - init-db, rev-parse --git-dir: do not append redundant slash
 - make_absolute_path(): Do not append redundant slash

The middle one needs replacement, as pointed by Hannes.

* pb/log-first-parent-p-m (2010-02-10) 1 commit
 - git log -p -m: document -m and honor --first-parent

Needs tests but otherwise looked fine.  We might want to teach "-m trumps
implicit --cc" to "git show", but that is a totally separate topic.

--------------------------------------------------
[Cooking]

Many of these have been parked in 'pu' during the pre-release freeze.
They will start migrating to 'next' shortly.

* sp/maint-push-sideband (2010-02-10) 8 commits
 - receive-pack: Send internal errors over side-band #2
 - t5401: Use a bare repository for the remote peer
 - receive-pack: Send hook output over side band #2
 - receive-pack: Wrap status reports inside side-band-64k
 - receive-pack: Refactor how capabilities are shown to the client
 - send-pack: demultiplex a sideband stream with status data
 - run-command: support custom fd-set in async
 - run-command: Allow stderr to be a caller supplied pipe
 (this branch is used by sp/push-sideband.)

Based on 1.6.5 maintenance track.

* sp/push-sideband (2010-02-10) 0 commits
 (this branch uses sp/maint-push-sideband.)

And my conflict resolution in #ifdef WINDOWS codepath.

* ac/cvsimport-revision-mapping (2010-02-06) 1 commit
 - cvsimport: new -R option: generate .git/cvs-revisions mapping

* jc/maint-1.6.3-imap-send-bool-config-fix (2010-02-06) 1 commit
 - imap-send: fix longstanding configuration parser bug

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

* rs/git-dir-cleanup (2010-02-11) 3 commits
  (merged to 'next' on 2010-02-11 at fa4f83c)
 + Untouch RelNotes 1.7.0: grep --no-index will not be in the release
  (merged to 'next' on 2010-02-06 at ef8ab9b)
 + Resurrect "git grep --no-index"
 + setenv(GIT_DIR) clean-up

* jc/typo (2010-02-03) 1 commit
 - Typofixes outside documentation area

* jk/grep-double-dash (2010-02-06) 1 commit
  (merged to 'next' on 2010-02-07 at 2ac040d)
 + accept "git grep -- pattern"

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
