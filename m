From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Mon, 23 Apr 2007 00:04:09 -0700
Message-ID: <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	<7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	<7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	<7vejmdq63w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 09:04:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfsb5-0003o8-Lr
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 09:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbXDWHEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 03:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbXDWHEM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 03:04:12 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:46122 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbXDWHEL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 03:04:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423070411.XYOF1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 23 Apr 2007 03:04:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qX491W00S1kojtg0000000; Mon, 23 Apr 2007 03:04:10 -0400
X-master-at: 4280cde95fa4e3fb012eb6d0c239a7777baaf60c
X-next-at: 25e0209251bbce8423639929565854fcf3c1d758
In-Reply-To: <7vejmdq63w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 21 Apr 2007 23:24:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45299>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/the-index (Sun Apr 1 23:26:07 2007 -0700) 2 commits
 + Make read-cache.c "the_index" free.
 + Move index-related variables into a structure.

I gave a brief look at the beginning of libification in
lcapitulino's repository at repo.or.cz, and I think this is
related to his topic, so instead of leaving this in limbo, I'm
planning to merge this in v1.5.2-rc1, hopefully to make the
later merge easier.

* mk/diff (Sun Apr 22 23:56:22 2007 -0700) 6 commits
 - Diff between two blobs should take mode changes into account now.
 - use mode of the tree in git-diff, if <tree>:<file> syntax is used
 - store mode in rev_list, if <tree>:<filename> syntax is used
 - add add_object_array_with_mode
 - add get_sha1_with_mode
 - Add S_IFINVALID mode

This attempts to do something we wanted to do for a long time
(the comment removed from the top of builtin-diff.c with this
series has been there for almost a year).  I haven't tried it
yet myself; it needs a few test.  This may help some parts of
gitweb so it would be desirable if we can fast-track this by
v1.5.2-rc1.

* jc/attr (Sat Apr 21 03:14:13 2007 -0700) 2 commits
 - Add 'filter' attribute and external filter driver definition.
 - Add 'ident' conversion.

As 'ident' conversion is stateless, I do not mind too much
including it in v1.5.2-rc1.  On the other hand, the arbitrary
'filter' is quite contentious, although the character-code
conversion example I gave myself might be a good enough reason
for people to want it.  Undecided.

* lt/objalloc (Mon Apr 16 22:13:09 2007 -0700) 1 commit
 - Make the object lookup hash use a "object index" instead of a
   pointer
* jc/blame (Tue Mar 27 01:58:01 2007 -0700) 4 commits
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
 - blame -s: suppress author name and time.
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

These are not considered for v1.5.2.
