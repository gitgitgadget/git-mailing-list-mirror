From: Bron Gondwana <brong@brong.net>
Subject: WANTED: patch splitting tool - waypoints
Date: Sun, 2 May 2010 21:58:42 +1000
Organization: brong.net
Message-ID: <20100502115842.GA11607@brong.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 14:10:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Y0S-000844-8q
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 14:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab0EBMKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 08:10:32 -0400
Received: from forward1.smtp.messagingengine.com ([66.111.4.223]:57955 "EHLO
	forward1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750980Ab0EBMKb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 08:10:31 -0400
X-Greylist: delayed 707 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 May 2010 08:10:31 EDT
Received: from launde (vpn58.internal [10.203.0.58])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B21A2F230F
	for <git@vger.kernel.org>; Sun,  2 May 2010 07:58:43 -0400 (EDT)
Received: by launde (Postfix, from userid 1000)
	id AAB9340BD9; Sun,  2 May 2010 21:58:42 +1000 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146167>

Hi,

My toolkit is missing a tool.  I've never seen it
or anything like it, but I can describe it - and
hopefully someone else knows if it exists.

It's basically a combination of git rebase -i and
git add -p.  Something that allows you to split
either a single patch or a series of patches that
had bad "waypoints".

You can imagine the patch as a journey from A to B.
Only, that's a long journey, and the path between
them is a big ugly code dump.  The commits along
the way include various adventures down rabbit holes
that got backed out much later without necessarily
tidying up the history along the way.

This tool allows you to easily generate one
intermediate state.  Repeated application generates
multiple intermediate states until you have a nice
tidy patch series, every step of the way bisectable.

So the journey A => B becomes the journey A => W => B.

The tool allows you to quickly choose which hunks to
add to patch(A=>W) and which to add to patch(W=>B),
but also lets you make edits to the intermediate state
easily so that W will compile even if some bits of the
patch were intermingled.


Does anybody know of a tool that can do this?  Does it
sounds like something others would use?  I'm thinking
that you could sort of get there with a combination of
rebase squash, git add -p and a git stash holding the
state of 'B', but it would need to be scripted enough
that repeated application isn't a pain.  And a graphical/
ncurses interface like the kernel's "make menuconfig" at
the very least would make it much easier than paging
through piles of diff fragments and hoping you never
made a mistake.

Regards,

Bron.
