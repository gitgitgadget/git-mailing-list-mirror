From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: I want to release a "git-1.0"
Date: Wed, 1 Jun 2005 18:00:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506011742560.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:03:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdbIF-0007yo-W4
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 00:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVFAWEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 18:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVFAWE2
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 18:04:28 -0400
Received: from iabervon.org ([66.92.72.58]:11782 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261286AbVFAWBz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 18:01:55 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DdbGh-00043h-00; Wed, 1 Jun 2005 18:00:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 31 May 2005, Linus Torvalds wrote:

> On Tue, 31 May 2005, Eric W. Biederman wrote:
> > 
> > I way behind the power curve on learning git at this point but
> > one piece of the puzzle that CVS has that I don't believe git does
> > are multiple people committing to the same repository, especially
> > remotely.  I don't see that as a down side of git but it is a common
> > way people CVS so it is worth documenting.
> 
> It's actually one thing git doesn't do per se.
> 
> You have to do a "git-pull-script" from the common repository side, 
> there's no "git-push-script". Ugly.

It shouldn't be hard to do one, except that locking with rsync is going to
be a pain. I had a patch to make it work with the rpush/rpull pair, but I
didn't get its dependancies in at the time. I can dust those patches off
again if you want that functionality included.

The patches are essentially:

 - make the transport protocol handle things other than objects
 - library procedure for locking atomic update of refs files
 - fetching refs in general
 - rpull/rpush that updates a specified ref file atomically

At least the first would be very nice to get in before 1.0, since it is an
incompatible change to the protocol.

	-Daniel
*This .sig left intentionally blank*

