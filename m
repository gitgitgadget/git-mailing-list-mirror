From: Peter Baumann <peter.baumann@gmail.com>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 16 Apr 2007 20:13:52 +0200
Message-ID: <20070416181352.GB29569@xp.machine.xx>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 16 20:20:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdVog-0001Mu-Ve
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 20:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbXDPSUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 14:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbXDPSUg
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 14:20:36 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54077 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1754131AbXDPSUg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 14:20:36 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Apr 2007 14:20:34 EDT
Received: (qmail 28659 invoked by uid 0); 16 Apr 2007 18:13:52 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 16 Apr 2007 18:13:52 -0000
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E1HdQah-0008Q2-7E@candygram.thunk.org>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44682>

On Mon, Apr 16, 2007 at 08:45:55AM -0400, Theodore Ts'o wrote:
> 
> I've recently noticed that I'm often firing up gitk for no other purpose
> than to see which changesets have which tags and branch heads.  Often
> I'll fire up gitk, quickly look at the tags/branches, and then kill it
> before it's done parsing the repository, resulting in python errors as
> it dies.
> 
> So I'm wondering why we haven't arranged to have git-log show this
> information, and whether there would be any objections if "git-log"
> showed something like this:
> 
> commit 7d5021d2ef5d414908d8e4db26c324c1de19f9f1
> Head: tytso-patches-20070223
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Fri Feb 23 14:46:01 2007 -0500
> 
> Cherry pick "unload head on shutdown" patch
> 
> ...
> 
> commit c8f71b01a50597e298dc3214a2f2be7b8d31170c
> Tag: v2.6.21-rc1
> Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
> Date:   Tue Feb 20 20:32:30 2007 -0800
> 
>     Linux 2.6.21-rc1
> 
> Would there be objections in adding this to --pretty=medium (i.e., the
> default), or would it be better to add something like tihs to
> --pretty=full or --pretty=fuller?
> 
> The only reason why I could imagine not doing this by default would be a
> potential performance problem if there were thousands of heads or branch
> heads.
> 
> 						- Ted

I'll do this gitk jump very often, too. Just to get the big picture where my
branches are (inside the commit graph). As they stay normaly on the tip, I
exit gitk long before it reached the root commit. What I'd like to have is
something which shows me _visually_ the the branches, e.g.

master
| next			commit comment for next
o  |		commit comment for master~1
|  o			commit comment for next~1
o  |	[ ... guess whats next :-)		you get the idea ...]
|  o
|  |
o /
|

tig comes near it, but it only linerarises the branches, so you can't see
where there was a mergepoint/fork. I'd really like these visuallization of
the commit graph in some of the text viewers. I normally don't care about
the _full_ commit text, only if I visually understand what's happening I'm
looking at the individual commits and the patches.

There was some tool (can't remember its name or who it wrote; but posted
here on this list) which visualizes  the relation horizontaly and not
vertically as shown above but has a limit of only displaying around 25 (not
sure about this number; but definitly below 30 commits) which was at least
displaying the commit graph which is _really_ really what I need.

-Peter
