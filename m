From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Tue, 29 May 2007 03:11:51 -0700
Message-ID: <7virac547s.fsf@assigned-by-dhcp.cox.net>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	<7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 12:12:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsygQ-000406-Rw
	for gcvg-git@gmane.org; Tue, 29 May 2007 12:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbXE2KLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 06:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbXE2KLx
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 06:11:53 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53897 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbXE2KLw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 06:11:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070529101152.RRSP22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 29 May 2007 06:11:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4yBr1X00E1kojtg0000000; Tue, 29 May 2007 06:11:52 -0400
X-master-at: 322bcd9a9a2c0081c66414bde64e0d443c9ec922
X-next-at: 6b3bae6ff1ca40827bbd7ffd83f2eae9271e4b14
In-Reply-To: <7vodkb1adr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 23 May 2007 14:46:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48678>

Tonight's 'next' is broken in that it does not seem to be able
to do "git cat-file -t aba170cdb4874b72dd619e6f7bbc13c33295f83".
If you add "1" to the end, it becomes the commit v1.5.2^0.
Bisecting shows "Lazily open pack index files on demand" is the
culprit, so I've reverted it locally (and made sure things
starts working again), but I haven't got around to pushing out
the results yet.  I won't, until tomorrow evening.

I'm a bit tired and it is getting late, so I won't comment on
each of the series.  I am seriously considering about merging
Pasky's applypatch removal soon to 'master'.

----------------------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* sp/pack (Tue May 29 02:49:08 2007 -0700) 4 commits
 . Revert "Lazily open pack index files on demand"
 + Attempt to delay prepare_alt_odb during get_sha1
 + Micro-optimize prepare_alt_odb
 + Lazily open pack index files on demand

* pb/am (Thu May 24 19:25:25 2007 -0700) 2 commits
 + Remove git-applypatch
 + git-applymbox: Remove command

* mk/pack (Mon May 28 23:20:59 2007 +0200) 3 commits
 + builtin-pack-object: cache small deltas
 + git-pack-objects: cache small deltas between big objects
 + builtin-pack-objects: don't fail, if delta is not possible

* lh/submodules (Sat May 26 15:56:40 2007 +0200) 1 commit
 + Add git-submodule command

* dh/repack (Fri May 25 14:40:24 2007 -0700) 1 commit
 - Enhance unpack-objects for live repo and large objects

* jc/blame (Fri Apr 20 16:25:50 2007 -0700) 4 commits
 - blame: show log as it goes
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
