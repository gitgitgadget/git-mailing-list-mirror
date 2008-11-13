From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2008, #04; Wed, 12)
Date: Wed, 12 Nov 2008 18:16:24 -0800
Message-ID: <7v8wrojrpj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 03:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0RmP-0004lw-Sr
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 03:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYKMCQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 21:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbYKMCQm
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 21:16:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbYKMCQl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 21:16:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 18CCF168D7;
	Wed, 12 Nov 2008 21:16:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 662C1168D6; Wed, 12 Nov 2008 21:16:26 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1B4E7B84-B129-11DD-817E-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100845>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

I think we should declare -rc0 by the end of this week, with the goal of
including everything that are in 'next' as of tonight, plus the "narrow
checkout" and possibly Pierre's send-email that acts as format-patch
frontend, by the time we hit -rc1, perhaps soon after the end of month.

----------------------------------------------------------------
[New Topics]

* mk/maint-cg-push (Mon Nov 10 22:47:11 2008 +0100) 1 commit
 + git push: Interpret $GIT_DIR/branches in a Cogito compatible way

* jk/commit-v-strip (Wed Nov 12 03:23:37 2008 -0500) 5 commits
 + status: show "-v" diff even for initial commit
 + Merge branch 'jk/maint-commit-v-strip' into jk/commit-v-strip
 + commit: Fix stripping of patch in verbose mode.
 + wt-status: refactor initial commit printing
 + define empty tree sha1 as a macro

* jk/maint-commit-v-strip (Wed Nov 12 03:25:52 2008 -0500) 1 commit
 + commit: Fix stripping of patch in verbose mode.

* ph/send-email (Tue Nov 11 00:54:02 2008 +0100) 4 commits
 - git send-email: ask less questions when --compose is used.
 - git send-email: add --annotate option
 - git send-email: interpret unknown files as revision lists
 - git send-email: make the message file name more specific.

* nd/rename-cache (Sat Nov 8 18:27:33 2008 +0700) 2 commits
 - diffcore-rename: add config option to allow to cache renames
 - diffcore-rename: support rename cache

----------------------------------------------------------------
[Will merge to "master" soon]

* jk/deny-push-to-current (Sat Nov 8 20:49:27 2008 -0500) 2 commits
 + receive-pack: detect push to current branch of non-bare repo
 + t5516: refactor oddball tests

* dl/xdiff (Fri Nov 7 21:24:33 2008 -0800) 1 commit
 + xdiff: give up scanning similar lines early

This performance fix may eventually need to be cherry-picked to 'maint'.

* lt/decorate (Wed Nov 12 11:51:28 2008 +0100) 7 commits
 + rev-list documentation: clarify the two parts of history
   simplification
 + Document "git log --simplify-by-decoration"
 + Document "git log --source"
 + revision traversal: '--simplify-by-decoration'
 + Make '--decorate' set an explicit 'show_decorations' flag
 + revision: make tree comparison functions take commits rather than
   trees
 + Add a 'source' decorator for commits

* gb/gitweb-snapshot-pathinfo (Sun Nov 2 10:21:39 2008 +0100) 3 commits
 + gitweb: embed snapshot format parameter in PATH_INFO
 + gitweb: retrieve snapshot format from PATH_INFO
 + gitweb: make the supported snapshot formats array global

Got sick of waiting for re-Ack.

* jn/gitweb-customlinks (Sun Oct 12 00:02:32 2008 +0200) 1 commit
 + gitweb: Better processing format string in custom links in navbar

Got sick of waiting for some sort of response from Pasky.

* st/tag (Wed Nov 5 00:20:36 2008 +0100) 2 commits
 + tag: Add more tests about mixing incompatible modes and options
 + tag: Check that options are only allowed in the appropriate mode

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 5 commits
 - autoconf: Enable threaded delta search when pthreads are supported
 + Add autoconf tests for pthreads
 + Make Pthread link flags configurable
 + Add Makefile check for FreeBSD 4.9-SECURITY
 + Build: add NO_UINTMAX_T to support ancient systems

I split the part that unconditionally enable threaded delta search on any
platform on which Pthread library is detected to be available from the
topmost one.  Will merge the rest to 'master' soon.

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

----------------------------------------------------------------
[Actively Cooking]

* bc/maint-keep-pack (Sun Nov 9 23:59:58 2008 -0600) 9 commits
 + pack-objects: extend --local to mean ignore non-local loose
   objects too
 + sha1_file.c: split has_loose_object() into local and non-local
   counterparts
 + t7700: demonstrate mishandling of loose objects in an alternate
   ODB
 + builtin-gc.c: use new pack_keep bitfield to detect .keep file
   existence
 + repack: do not fall back to incremental repacking with [-a|-A]
 + repack: don't repack local objects in packs with .keep file
 + pack-objects: new option --honor-pack-keep
 + packed_git: convert pack_local flag into a bitfield and add
   pack_keep
 + t7700: demonstrate mishandling of objects in packs with a .keep
   file

A few commits were rewound from 'next' and replaced with new ones.

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

* mv/remote-rename (Mon Nov 10 21:43:03 2008 +0100) 4 commits
 + git-remote: document the migration feature of the rename
   subcommand
 + git-remote rename: migrate from remotes/ and branches/
 + remote: add a new 'origin' variable to the struct
 + Implement git remote rename

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
