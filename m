From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2008, #03; Sun, 09)
Date: Sun, 09 Nov 2008 16:09:12 -0800
Message-ID: <7vod0o8ms7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 01:10:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzKMi-0000H5-3j
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 01:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766AbYKJAJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 19:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756758AbYKJAJa
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 19:09:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699AbYKJAJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 19:09:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 38ACB95C7C;
	Sun,  9 Nov 2008 19:09:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4C42895C7B; Sun, 
 9 Nov 2008 19:09:14 -0500 (EST)
X-master-at: a9645b780b698703cd7dee25051d6ce39b0544c6
X-next-at: aca556e49fea7423c223973632ed9b94c03b19eb
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D5ED960C-AEBB-11DD-B211-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100480>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* jk/deny-push-to-current (Sat Nov 8 20:49:27 2008 -0500) 2 commits
 + receive-pack: detect push to current branch of non-bare repo
 + t5516: refactor oddball tests

* dl/xdiff (Fri Nov 7 21:24:33 2008 -0800) 1 commit
 + xdiff: give up scanning similar lines early

This performance fix may eventually need to be cherry-picked to 'maint'.

----------------------------------------------------------------
[Graduated to "master"]

* cb/maint-update-ref-fix (Wed Nov 5 21:55:54 2008 +0100) 2 commits
 + push: fix local refs update if already up-to-date
 + do not force write of packed refs

* rs/blame (Sat Oct 25 15:31:36 2008 +0200) 5 commits
 + blame: use xdi_diff_hunks(), get rid of struct patch
 + add xdi_diff_hunks() for callers that only need hunk lengths
 + Allow alternate "low-level" emit function from xdl_diff
 + Always initialize xpparam_t to 0
 + blame: inline get_patch()

* ds/autoconf (Sun Oct 26 03:52:19 2008 -0800) 1 commit
 + autoconf: Add link tests to each AC_CHECK_FUNC() test

Attempts to help FreeBSD whose compiler does not error out when told to
compile a program that calls unavailable functions.

----------------------------------------------------------------
[Actively Cooking]

* gb/gitweb-snapshot-pathinfo (Sun Nov 2 10:21:39 2008 +0100) 3 commits
 + gitweb: embed snapshot format parameter in PATH_INFO
 + gitweb: retrieve snapshot format from PATH_INFO
 + gitweb: make the supported snapshot formats array global

Got sick of waiting for re-Ack.  Merged to 'next'.

* jn/gitweb-customlinks (Sun Oct 12 00:02:32 2008 +0200) 1 commit
 + gitweb: Better processing format string in custom links in navbar

Got sick of waiting for some sort of response from Pasky.  Merged to 'next'.

* st/tag (Wed Nov 5 00:20:36 2008 +0100) 2 commits
 + tag: Add more tests about mixing incompatible modes and options
 + tag: Check that options are only allowed in the appropriate mode

* np/pack-safer (Sun Nov 9 13:11:06 2008 -0800) 11 commits
 + t5303: fix printf format string for portability
 + t5303: work around printf breakage in dash
 + pack-objects: don't leak pack window reference when splitting
   packs
 + extend test coverage for latest pack corruption resilience
   improvements
 + pack-objects: allow "fixing" a corrupted pack without a full
   repack
 + make find_pack_revindex() aware of the nasty world
 + make check_object() resilient to pack corruptions
 + make packed_object_info() resilient to pack corruptions
 + make unpack_object_header() non fatal
 + better validation on delta base object offsets
 + close another possibility for propagating pack corruption

* mv/remote-rename (Mon Nov 3 19:26:18 2008 +0100) 1 commit
 + Implement git remote rename

* lt/decorate (Mon Nov 3 11:25:46 2008 -0800) 4 commits
 + revision traversal: '--simplify-by-decoration'
 + Make '--decorate' set an explicit 'show_decorations' flag
 + revision: make tree comparison functions take commits rather than
   trees
 + Add a 'source' decorator for commits

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 5 commits
 - autoconf: Enable threaded delta search when pthreads are supported
 + Add autoconf tests for pthreads
 + Make Pthread link flags configurable
 + Add Makefile check for FreeBSD 4.9-SECURITY
 + Build: add NO_UINTMAX_T to support ancient systems

I split the part that unconditionally enable threaded delta search on any
platform on which Pthread library is detected to be available from the
topmost one.

* jk/diff-convfilter (Sun Oct 26 00:50:02 2008 -0400) 8 commits
 + enable textconv for diff in verbose status/commit
 + wt-status: load diff ui config
 + only textconv regular files
 + userdiff: require explicitly allowing textconv
 + refactor userdiff textconv code
 + add userdiff textconv tests
 + document the diff driver textconv feature
 + diff: add missing static declaration

* jk/diff-convfilter-test-fix (Fri Oct 31 01:09:13 2008 -0400) 4 commits
 + Avoid using non-portable `echo -n` in tests.
 + add userdiff textconv tests
 + document the diff driver textconv feature
 + diff: add missing static declaration

An update to the one above.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

* nd/narrow (Wed Oct 1 11:04:09 2008 +0700) 9 commits
 - grep: skip files outside sparse checkout area
 - checkout_entry(): CE_NO_CHECKOUT on checked out entries.
 - Prevent diff machinery from examining worktree outside sparse
   checkout
 - ls-files: Add tests for --sparse and friends
 - update-index: add --checkout/--no-checkout to update
   CE_NO_CHECKOUT bit
 - update-index: refactor mark_valid() in preparation for new options
 - ls-files: add options to support sparse checkout
 - Introduce CE_NO_CHECKOUT bit
 - Extend index to save more flags

Early parts looked Ok; I am trying to find time to review the whole thing
but fixing bugs in topics from other people here and there took almost all
my time this weekend.  Not good.

----------------------------------------------------------------
[Dropped]

* bc/maint-keep-pack (Mon Nov 3 14:43:22 2008 -0600) 3 commits
 . pack-objects: honor '.keep' files
 . packed_git: convert pack_local flag into a bitfield and add
   pack_keep
 . t7700: demonstrate mishandling of objects in packs with a .keep
   file

It seems this is better rethought from the design level.

----------------------------------------------------------------
[On Hold]

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

This seems to have a deadlock during communication between the peers.
Someone needs to pick up this topic and resolve the deadlock before it can
continue.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use,
but gitk will be hit due to tcl/tk's limitation, so I am holding
this back for now.
