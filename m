From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sun, 13 May 2007 15:29:49 -0700
Message-ID: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 00:29:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnMZh-0002ww-42
	for gcvg-git@gmane.org; Mon, 14 May 2007 00:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbXEMW3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 18:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755415AbXEMW3v
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 18:29:51 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46658 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413AbXEMW3u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 18:29:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513222950.ZRZR2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 18:29:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ymVp1W00L1kojtg0000000; Sun, 13 May 2007 18:29:50 -0400
X-master-at: 43d151a1b087db22e2f9a754772b469de1194f67
X-next-at: b0896b86db2572b7e845160951edd9ac4eb96603
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47186>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* sp/cvsexport (Thu May 10 01:06:36 2007 +0200) 1 commit
 - Optimized cvsexportcommit: calling 'cvs status' once instead of
   once per touched file.

This is waiting for Ack/Nack to make sure there is no unexpected
side effects but I am hoping we can ship v1.5.2 with this.

* dh/pack (Wed May 9 13:56:50 2007 -0700) 3 commits
 + Custom compression levels for objects and packs
 + make "repack -f" imply "pack-objects --no-reuse-object"
 + allow for undeltified objects not to be reused
* tt/gc (Wed May 9 15:48:39 2007 -0400) 1 commit
 + Add --aggressive option to 'git gc'
* np/pack (Wed May 9 14:42:42 2007 -0400) 3 commits
 + deprecate the new loose object header format
 + make "repack -f" imply "pack-objects --no-reuse-object"
 + allow for undeltified objects not to be reused
* sv/checkout (Wed May 9 12:33:20 2007 +0200) 1 commit
 + git-update-ref: add --no-deref option for overwriting/detaching
   ref
* jb/statcolor (Sat May 5 16:48:54 2007 -0400) 1 commit
 + Add colour support in rebase and merge tree diff stats output.

New features, all deemed to be safe.  To merge early after v1.5.2.

* db/remote (Sat May 12 11:46:03 2007 -0400) 3 commits
 - Add handlers for fetch-side configuration of remotes.
 - Move refspec parser from connect.c and cache.h to remote.{c,h}
 - Move remote parsing into a library file out of builtin-push.

Hopefully be in 'next' after v1.5.2; I haven't really played
with it.  The next step would probably be to add some stuff that
use this series in fetch--tool, to further rewrite git-fetch
itself in C, or maybe wholesale rewrite of git-fetch in C.

* dh/repack (Tue May 8 13:05:04 2007 -0700) 5 commits
 - git-repack --max-pack-size: add option parsing to enable feature
 - git-repack --max-pack-size: split packs as asked by
   write_{object,one}()
 - git-repack --max-pack-size: write_{object,one}() respect pack
   limit
 - git-repack --max-pack-size: new file statics and code
   restructuring
 - Alter sha1close() 3rd argument to request flush only

Hopefully will have a series rebased on top of 'master' after
the first batch after v1.5.2 graduates.

* jc/blame (Fri Apr 20 16:25:50 2007 -0700) 4 commits
 - blame: show log as it goes
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

Stalled.
