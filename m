From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 23:50:39 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710182340550.19446@xanadu.home>
References: <20071019004527.GA12930@spearce.org>
 <20071019021255.GD3290@coredump.intra.peff.net>
 <20071019022154.GY14735@spearce.org>
 <20071019023425.GB8298@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
 <20071019030749.GA9274@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182312160.19446@xanadu.home>
 <20071019033228.GA10697@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:50:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiisu-0002uv-VG
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763720AbXJSDul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762259AbXJSDul
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:50:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8951 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759439AbXJSDuk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:50:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ500LSK40FNNO0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 23:50:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019033228.GA10697@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61640>

On Thu, 18 Oct 2007, Jeff King wrote:

> On Thu, Oct 18, 2007 at 11:24:41PM -0400, Nicolas Pitre wrote:
> 
> > You usually get long lines that gets wrapped, so that means 3 lines of 
> > screen space for one updated branches.  Is the "66ffb04..4fa4d23" 
> > information really useful?  Might someone ever care?
> 
> I have used it occasionally when tracking repos to see what new commits
> have happened. Usually I use a separate branch to mark "what I've seen"
> (i.e., fetch, gitk origin..master, pull), but if it's a branch that I'm
> not actively tracking, the display is useful.

Maybe we should have a shortcut notation for <ref>@{1}..<ref> instead?
I end up using that all the time since the fetch result has long 
scrolled off the screen when I want to look at what was fetched.

Usully this llooks like:

	git pull
	git log @{1}..

But using origin/master@{1}..origin/master is a bit cumbersome.

> What is really useless in that line is the fact that _every_ ref is
> going to have the name of the remote, even though we only support
> fetching from one remote at a time. Perhaps something like:
> 
> Fetching from git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>  * refs/heads/origin: fast forward to branch 'master'
> 
> although that URL is almost a line by itself. :)

It is, therefore I'd skip "Fetching from " entirely.

> Also, why do we abbreviate "refs/heads/master" from the remote, but we
> don't abbreviate refs/heads/origin for the local? Maybe something like:
> 
>   * local heads/origin -> remote heads/master (fast forward)
> 
> or for separate remote
> 
>   * local remotes/origin/master -> remote heads/master (fast forward)

That looks fine for a push.  I'd say "remote foo -> local bar" for a 
fetch.


Nicolas
