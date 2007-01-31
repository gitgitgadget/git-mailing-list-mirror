From: Nicolas Pitre <nico@cam.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 09:59:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701310932320.3021@xanadu.home>
References: <87odognuhl.wl%cworth@cworth.org>
 <20070130231015.GB10075@coredump.intra.peff.net>
 <7vzm80vv1s.fsf@assigned-by-dhcp.cox.net>
 <20070131032248.GA17504@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 15:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCGva-0000to-7U
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 15:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933322AbXAaO7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 09:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933323AbXAaO7K
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 09:59:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:59259 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933322AbXAaO7J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 09:59:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCQ009W7MYKAT50@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 31 Jan 2007 09:59:08 -0500 (EST)
In-reply-to: <20070131032248.GA17504@coredump.intra.peff.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38254>

On Tue, 30 Jan 2007, Jeff King wrote:

> I just think it is awkward to have to either see such a warning
> (or use -f) just to _look_ at detached commits, when you aren't doing
> anything even remotely dangerous. The dangerous thing is _creating_
> commits on top of a detached head.  I honestly don't think it should be
> allowed at all, but since some people have argued that it is useful,
> that seems like the place to put warnings. Anything else is just making
> things more confusing for the sorts of people Carl is dealing with --
> those who merely want to look around.

I disagree again.  Making commits on a detached head is not dangerous.

What is dangerous is moving away from the tip of that detached head 
without attaching it somewhere.  And that case is well covered already.

Also the warning when moving to a detached head is useful to make the 
user aware of what just happened because there is really something 
special about such checkout.  It is not meant to frighten users and if 
it does so then maybe it should be reworked some more.  But IMHO it is 
important that the user be aware of this special state.

But making a warning at commit time is wrong. It is completely 
disconnected from the actual issue and I think it'd create more 
confusion because there is in fact nothing to worry about at the moment 
the commit is made.  The very fact that you think yourself that a 
warning should be displayed at commit time indicates to me that you 
might be a bit confused yourself and such warning if present at commit 
time wouldn't help clearing that confusion at all.

> > For situations like Carl's intstruction where a user, who is
> > purely a sightseer, uses the detached HEAD to go-and-look a
> > particular state, the fact that "-f" loses the previous local
> 
> Yes, though it would be nicer not to have to explain to them why '-f' is
> needed.

In Carl's case suggesting -f is probably not a good idea.  Using -f _is_ 
dangerous and we better not get people into the habit of using -f 
without thinking.

Let's focus on the real issue: the warning message when head gets 
detached.  This message is not meant to frighten users.  It is meant to 
make the user aware of a special state (pretty useful but special 
nevertheless) and give a suggestion about what to do if that state was 
entered by mistake.  So if that message scares users away then it is the 
message itself which is buggy not its presence.


Nicolas
