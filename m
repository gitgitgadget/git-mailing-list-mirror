From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Thu, 2 Jun 2005 15:12:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506021452030.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506020741480.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tony Lindgren <tony@atomide.com>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 21:12:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddv67-00073z-Li
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 21:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFBTOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 15:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVFBTOU
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 15:14:20 -0400
Received: from iabervon.org ([66.92.72.58]:53511 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261231AbVFBTOR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 15:14:17 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Ddv7H-0005DO-00; Thu, 2 Jun 2005 15:12:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506020741480.1876@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Jun 2005, Linus Torvalds wrote:

> The real reason I'd prefer to not do locking is that _if_ the remote tree
> is actually more than just a CVS-like "public repository", ie if somebody
> actually does _development_ in the remote tree (hey, it may be crazy, but
> git makes this usage pattern possible), then we should eventually plan on
> having all of the regular "git-commit-script" and "git-pull-script" etc
> _also_ do locking, since they also change HEAD.

It might be okay to have a single tree to which is applied patches from
emails sent by non-maintainers, pulls from non-maintainers with accessible
repositories, and pushes from home repositories of maintainers. It makes
sense to deal well with different ways to get refined commits into the
public repository. Of course, you probably don't want to carry out merges
there, so the cases where pull or commit loses the race are quite
different; you want to throw it back to the author for rebasing.

	-Daniel
*This .sig left intentionally blank*

