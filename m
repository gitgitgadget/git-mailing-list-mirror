From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Wed, 18 May 2005 23:35:29 +0200
Message-ID: <20050518213529.GE10358@pasky.ji.cz>
References: <20050517214533.GP7136@pasky.ji.cz> <Pine.LNX.4.21.0505171802570.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 18 23:38:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYWCa-0003J2-Mh
	for gcvg-git@gmane.org; Wed, 18 May 2005 23:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVERVfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 17:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVERVfs
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 17:35:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37516 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262382AbVERVfd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 17:35:33 -0400
Received: (qmail 7689 invoked by uid 2001); 18 May 2005 21:35:29 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505171802570.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, May 18, 2005 at 12:20:40AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Tue, 17 May 2005, Petr Baudis wrote:
> 
> > Dear diary, on Tue, May 17, 2005 at 11:20:54PM CEST, I got a letter
> > where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > > Hmm... maybe the right thing is to make the implementation-provided
> > > transfer code handle arbitrary things in GIT_DIR, but have code for
> > > updating reference files atomically and using a reference file to start
> > > from use "refs/"? Certainly, there's nothing special about reference files
> > > in transit.
> > > 
> > > Certainly the things in the info/ directory shouldn't be treated a head
> > > that you're going to pull, so that has to be different above the protocol
> > > level anyway.
> > 
> > *confused* :) I'm sorry, I have trouble understanding this. Could you
> > rephrase, please?
> 
> If you want to get info/ignore, you want to get it and save it, not
> download a set of objects it refers to. So it's different from specifying
> that you want to use refs/heads/master as the starting point for a pull.

Obviously. I think you should need to "explicitly" tell pull to actually
save any files locally, since you (I mean Cogito) certainly does not
want the pull stuff to touch the local refs/heads/master - it wants it
in some other file.

> > > So the remote receiver should get an instruction: change X from OLD to NEW
> > > and pull NEW. It should:
> > > 
> > >  - lock the file against further updates
> > >  - check that the current value is the provided OLD
> > >  - pull the necessary objects
> > >  - write NEW to the file
> > - unlock the file ;-))
> 
> The way I'm actually doing things is to write NEW into the lock file at
> some arbitrary point, and "writing to the file" is actually renaming the
> lock file to the normal filename. So writing unlocks the file
> automatically.

Ah. Obviously. That makes sense. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
