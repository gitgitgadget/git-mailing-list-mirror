From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Terminology question about remote branches.
Date: Sun, 05 Aug 2007 00:31:04 -0700
Message-ID: <7v8x8qfnev.fsf@assigned-by-dhcp.cox.net>
References: <854pjfin68.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 09:31:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHaZz-0008Mx-Di
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 09:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbXHEHbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 03:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753806AbXHEHbH
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 03:31:07 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:59768 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbXHEHbH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 03:31:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805073105.KBRR2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 03:31:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y7X41X00C1kojtg0000000; Sun, 05 Aug 2007 03:31:04 -0400
In-Reply-To: <854pjfin68.fsf@lola.goethe.zz> (David Kastrup's message of "Sat,
	04 Aug 2007 12:55:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54960>

David Kastrup <dak@gnu.org> writes:

> I am trying to dig through man-pages and user manual and trying to
> match them with reality.  I seem to have a hard time.  My current
> understanding (which definitely differs from the documented state) is
> that there are two types of branches, local and remote branches, and
> both types of branches can be remote-tracking (it may not be possible
> to have a non-remote-tracking remote branch, though).

I think we have a brief discussion on #git before you brought
this up ;-)

 - local branches -- we know what they are.

 - remote tracking branches -- refs that appear in refs/remotes/
   in the current world order; they are updated only by copying
   the corresponding local branches at the remote site, and are
   meant to "keep track of what _they_ are doing".  In olden
   days before 1.5.0 with non separate remote layout,
   'refs/heads/origin' branch, and all the non default branches,
   were treated this way as well.  You were not supposed to make
   commit on them (because of the above "keep track of" reason),
   and having them under refs/heads were too confusing, which
   was the reason the separate remote layout was invented.

You can have a local branch that is created by forking off of a
remote tracking branch, with the intention to "build on top" of
the corresponding remote tracking brach.  You can create such a
branch and mark it as such with --track option introduced in
v1.5.1 timeperiod.  This is a relatively new concept, but many
people find it useful.  We do not have the official term to call
this concept, and some people have misused the term "remote
tracking branches" to describe this, which made things very
confusing.

We would need an official terminology for it.
