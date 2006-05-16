From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Mon, 15 May 2006 22:30:36 -0700
Message-ID: <7vodxyedtv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 16 07:30:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffs8u-0006FD-9F
	for gcvg-git@gmane.org; Tue, 16 May 2006 07:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWEPFai (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 01:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWEPFah
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 01:30:37 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:30187 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751297AbWEPFah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 01:30:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516053036.HNAW17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 01:30:36 -0400
To: git@vger.kernel.org
X-maint-at: 1b9bc5a7b7434d771726011613a00cb202bd9f44
X-master-at: 8701ea0f627dcba4bb75570f87df9c93985d397a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20101>

* The 'maint' branch produced the v1.3.3 release I announced
  just a minute ago.

* The 'master' branch has these since the last announcement.

 - 64-bit (especially BE) fix for pack-objects (Dennis Stosberg)

 - Porting issues (Dennis Stosberg, Ben Clifford)
 
 - send-email updates (Eric Wong)

 - built-in "grep" (Linus and me)

 - "reset --hard" simplification (Linus and me)

 - configuration file syntax updates (Linus)

 - cvsserver updates (Martin Langhoff, Martyn Smith)

 - delta generation fix (Nicolas Pitre)

 - "git commit" novice usability fix (Sean Estabrooks)


* The 'next' branch, in addition, has these.

 - "diff revA:path1 revB:path2" fix

   When two blobs are given, it produced diff in reverse by
   mistake ("setup_revisions()" left the parsed objects in
   reverse order, and the caller forgot to reverse it).

   This is trivial and ready -- I just haven't got around to
   merging it up.

 - "rebase" help text updates (Sean Estabrooks)

   Ready.

 - "diff --summary" (Sean Estabrooks)

   I haven't really read the code yet, but it is low impact and
   should be ready.

 - strip leading tags/ from "git tag -l" output (Sean Estabrooks) 

   "git tag -l" as I wrote it originally stupidly left leading tags/
   in its output for all tags.  This removes it, and I think it
   is a sensible thing to do.

 - move remotes/ to config (Johannes)

   Now configuration syntax discussion is settled, thanks to
   Linus, we can start discussing per-branch attribute
   semantics.  This series is about the other half of the story.

   I think it is ready as it is, if we are not going to change
   the semantics of "remote"; except some people seem to want to
   reorganize the way per-branch property and remotes interact
   with each other.

 - Further optimiation of pack-object (Nicolas Pitre)

   Testing.

 - "apply --cached"

   This allows "git apply" to apply a patch to the index without
   touching the working tree.  It is handy to prepare a tree to
   use in 3-way fallback, and updated "git am" takes advantage
   of it.  I am planning to use it for stash/unstash.

 - built-in format-patch (Johannes) 

   I think this is almost ready to supersede the script version,
   except that this does not do attachments.

   We need to do RFC2047 for headers as well.  I'd rather do it
   in this version than fix the script version.

 - cache-tree with read-tree/write-tree --prefix

   I haven't made any progress on this one, but haven't been
   bitten by it either, so it is a good sign.
