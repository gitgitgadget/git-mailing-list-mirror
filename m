From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Thu, 18 Oct 2007 23:32:28 -0400
Message-ID: <20071019033228.GA10697@coredump.intra.peff.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <20071019023425.GB8298@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182251110.19446@xanadu.home> <20071019030749.GA9274@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182312160.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiibL-0000k8-J0
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933923AbXJSDcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760588AbXJSDcb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:32:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3447 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760580AbXJSDca (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:32:30 -0400
Received: (qmail 8573 invoked by uid 111); 19 Oct 2007 03:32:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 23:32:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 23:32:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182312160.19446@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61632>

On Thu, Oct 18, 2007 at 11:24:41PM -0400, Nicolas Pitre wrote:

> Frankly, I think effort should be spent on the refs update display at 
> this point.  Something that looks like:

Also agreed.

> * refs/heads/origin: fast forward to branch 'master' of git://gi
> t.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>   old..new: 66ffb04..4fa4d23
>
> [...]
>
> You usually get long lines that gets wrapped, so that means 3 lines of 
> screen space for one updated branches.  Is the "66ffb04..4fa4d23" 
> information really useful?  Might someone ever care?

I have used it occasionally when tracking repos to see what new commits
have happened. Usually I use a separate branch to mark "what I've seen"
(i.e., fetch, gitk origin..master, pull), but if it's a branch that I'm
not actively tracking, the display is useful.

What is really useless in that line is the fact that _every_ ref is
going to have the name of the remote, even though we only support
fetching from one remote at a time. Perhaps something like:

Fetching from git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * refs/heads/origin: fast forward to branch 'master'

although that URL is almost a line by itself. :)

Also, why do we abbreviate "refs/heads/master" from the remote, but we
don't abbreviate refs/heads/origin for the local? Maybe something like:

  * local heads/origin -> remote heads/master (fast forward)

or for separate remote

  * local remotes/origin/master -> remote heads/master (fast forward)

Thoughts?

-Peff
