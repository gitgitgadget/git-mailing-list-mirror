From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sun, 15 Apr 2007 18:53:49 -0700
Message-ID: <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 03:53:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdGPi-0006tu-Sv
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 03:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbXDPBxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 21:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbXDPBxv
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 21:53:51 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50074 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbXDPBxu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 21:53:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416015349.OBJJ1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 21:53:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ndtp1W00m1kojtg0000000; Sun, 15 Apr 2007 21:53:50 -0400
X-master-at: 7a1593972c19df26aee7d14c7d7c8c4fce24fb26
X-next-at: 88bdbb881e223ae39039be804e87094505f6d998
In-Reply-To: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 09 Apr 2007 01:17:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44561>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* lt/gitlink (Sun Apr 15 11:14:28 2007 -0700) 17 commits
 + Expose subprojects as special files to "git diff" machinery
 + Fix some "git ls-files -o" fallout from gitlinks
 + Teach "git-read-tree -u" to check out submodules as a directory
 + Teach git list-objects logic to not follow gitlinks
 + Fix gitlink index entry filesystem matching
 + Teach "git-read-tree -u" to check out submodules as a directory
 + Teach git list-objects logic not to follow gitlinks
 + Don't show gitlink directories when we want "other" files
 + Teach git-update-index about gitlinks
 + Teach directory traversal about subprojects
 + Fix thinko in subproject entry sorting
 + Teach core object handling functions about gitlinks
 + Teach "fsck" not to follow subproject links
 + Add "S_IFDIRLNK" file mode infrastructure for git links
 + Add 'resolve_gitlink_ref()' helper function
 + Avoid overflowing name buffer in deep directory structures
 + diff-lib: use ce_mode_from_stat() rather than messing with modes
   manually

Everybody loves when Linus jumps in and gets the ball rolling
for a topic that has been only an idle-talk wishlist with a
minimum set of patches.  Let's see where this goes.

* jc/attr (Sat Apr 14 21:27:20 2007 -0400) 10 commits
 - Document git-check-attr
 - Change attribute negation marker from '!' to '-'.
 - Define a built-in attribute macro "binary".
 - attribute macro support
 + Makefile: add patch-ids.h back in.
 + Fix 'diff' attribute semantics.
 + Fix 'crlf' attribute semantics.
 + Teach 'diff' about 'diff' attribute.
 + Define 'crlf' attribute.
 + Add basic infrastructure to assign attributes to paths

... and I tried to learn from that.  I do not know how
successful I was, though.

But I earlier said that one of the focus of 1.5.2 should be the
gitattributes support.

* fl/cvsserver (Fri Apr 13 18:13:42 2007 +0200) 12 commits
 + config.txt: Add gitcvs.db* variables
 + cvsserver: Document the GIT branches -> CVS modules mapping more
   prominently
 + cvsserver: Reword documentation on necessity of write access
 + cvsserver: Allow to "add" a removed file
 + cvsserver: Add asciidoc documentation for new database backend
   configuration
 + cvsserver: Corrections to the database backend configuration
 + cvsserver: Use DBI->table_info instead of DBI->tables
 + cvsserver: Abort if connect to database fails
 + cvsserver: Make the database backend configurable
 + cvsserver: Allow to override the configuration per access method
 + cvsserver: Handle three part keys in git config correctly
 + cvsserver: Introduce new state variable 'method'

Waiting for Ack's from the field, which unfortunately I haven't
seen any yet.

* np/pack (Tue Apr 10 22:54:36 2007 -0400) 16 commits
 + clean up add_object_entry()
 + tests for various pack index features
 + use test-genrandom in tests instead of /dev/urandom
 + simple random data generator for tests
 + validate reused pack data with CRC when possible
 + allow forcing index v2 and 64-bit offset treshold
 + pack-redundant.c: learn about index v2
 + show-index.c: learn about index v2
 + sha1_file.c: learn about index version 2
 + index-pack: learn about pack index version 2
 + pack-objects: learn about pack index version 2
 + compute object CRC32 with index-pack
 + compute a CRC32 for each object as stored in a pack
 + add overflow tests on pack offset variables
 + make overflow test on delta base offset work regardless of
   variable size
 + get rid of num_packed_objects()

Haven't seen any breakage report so far.  After giving them a
final look, let's push this out to 'master' soonish.

* js/wrap-log (Sun Apr 8 01:28:00 2007 -0700) 2 commits
 + shortlog -w: make wrap-line behaviour optional.
 + Use print_wrapped_text() in shortlog

I do not think it breaks anything but I do not think we are in a
hurry, either.

* jc/read-tree-df (Sat Apr 7 07:17:35 2007 -0700) 5 commits
 + t3030: merge-recursive backend test.
 + merge-recursive: handle D/F conflict case more carefully.
 + merge-recursive: do not barf on "to be removed" entries.
 + Treat D/F conflict entry more carefully in unpack-
   trees.c::threeway_merge()
 + t1000: fix case table.

This series should not matter in practice as I do not think any
project that changes between directory and file is sane, but
people are known to do insane things, and this would help them.

Any comments for or against their graduation to 'master'?

* jc/quickfetch (Thu Apr 5 03:22:55 2007 -0700) 2 commits
 + git-fetch: use fetch--tool pick-rref to avoid local fetch from
   alternate
 + git-fetch--tool pick-rref

This would make fetching from your alternate more efficient by
not fetching any objects (because by definition it is not
necessary).  It doubly matters in this case performance-wise as
the recent code verifies fetched objects that were already in
the repository, which tends to be expensive.

* jc/the-index (Sun Apr 1 23:26:07 2007 -0700) 2 commits
 - Make read-cache.c "the_index" free.
 - Move index-related variables into a structure.

Sort of "libification", which nobody seems to need right now,
but I did it already and there is no reason to throw away.

* jc/blame (Tue Mar 27 01:58:01 2007 -0700) 4 commits
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
 - blame -s: suppress author name and time.
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

Stalled.
