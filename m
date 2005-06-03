From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: I want to release a "git-1.0"
Date: Fri, 3 Jun 2005 11:09:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506031102490.30848-100000@iabervon.org>
References: <20050603094706.GB24873@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 17:10:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeDlb-0000QZ-Vc
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 17:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVFCPKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 11:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVFCPKa
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 11:10:30 -0400
Received: from iabervon.org ([66.92.72.58]:57863 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261318AbVFCPKW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 11:10:22 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DeDnH-0002im-00; Fri, 3 Jun 2005 11:09:07 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050603094706.GB24873@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 3 Jun 2005, Petr Baudis wrote:

> Dear diary, on Thu, Jun 02, 2005 at 12:00:55AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > It shouldn't be hard to do one, except that locking with rsync is going to
> > be a pain. I had a patch to make it work with the rpush/rpull pair, but I
> > didn't get its dependancies in at the time.
> 
> Was that the patch I was replying to recently? It didn't seem to have
> any dependencies.

The rpush/rpull changes were at the end of a series that you were replying
to the beginning of.

> > I can dust those patches off again if you want that functionality included.
> > 
> > The patches are essentially:
> > 
> >  - make the transport protocol handle things other than objects
> >  - library procedure for locking atomic update of refs files
> >  - fetching refs in general
> >  - rpull/rpush that updates a specified ref file atomically
> > 
> > At least the first would be very nice to get in before 1.0, since it is an
> > incompatible change to the protocol.
> 
> I would like to have this a lot too. Pulling tags now is a PITA, and I
> definitively want to go in this way. So it will land at least in git-pb.
> :-) (But that's a little troublesome if you say it's incompatible
> change.)

The ssh-based protocol has to change, because the current version doesn't
have any way of being extended. The first patch in the new set makes the
incompatible change without adding anything new (so as to be as
uncontroversial as possible), and now also adds a version number so that
future additions should be less of a big deal. The rest of the series will
add the transfer of refs to the transfer mechanism and the protocol.

	-Daniel
*This .sig left intentionally blank*

