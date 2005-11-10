From: Petr Baudis <pasky@suse.cz>
Subject: Re: Do I misunderstand cg-merge --squash option
Date: Thu, 10 Nov 2005 22:16:37 +0100
Message-ID: <20051110211637.GA30496@pasky.or.cz>
References: <200511100025.05993.alan@chandlerfamily.org.uk> <200511101915.53736.alan@chandlerfamily.org.uk> <20051110192923.GT30496@pasky.or.cz> <200511102036.06484.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 22:18:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaJml-0007QX-Ic
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 22:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVKJVQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 16:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVKJVQk
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 16:16:40 -0500
Received: from w241.dkm.cz ([62.24.88.241]:15060 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932078AbVKJVQj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 16:16:39 -0500
Received: (qmail 13872 invoked by uid 2001); 10 Nov 2005 22:16:37 +0100
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200511102036.06484.alan@chandlerfamily.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11528>

Dear diary, on Thu, Nov 10, 2005 at 09:36:06PM CET, I got a letter
where Alan Chandler <alan@chandlerfamily.org.uk> said that...
> On Thursday 10 Nov 2005 19:29, Petr Baudis wrote:
> 
> >
> > Right now, what about trying to manually select the merge base?
> >
> > 	public$ cg-merge -b v1.0 master
> 
> Actually, that does merge very nicely.  However, I don't think its what I 
> want. From gitk I get both routes back to my initial commit, both the fast 
> track one and the slow train via all stations en-route.
> 
> I have had more success with grafting (which you kindly informed me about 
> yesterday)
> 
> something like
> 
> echo `cg-object-id v1.0` `cg-object-id initial_commit` >.git/info/grafts
> 
> lf I make a branch out of the parent of v1.0 before doing this,  I end up with 
> there being a side branch of the old history and my master branch headed back 
> through a quick route to the initial_commit.

Huh. But you still have the history cluttered and both routes to your
initial commit, don't you? I'm now confused - I fear I don't know what
you want anymore. But well, whatever is working out for you... ;-)

> Something strange (well actually not that unexpected, the more I think about 
> it) has happened though.  
> 
> I was trying to see if cg-clone would effectively me make a new repository 
> without the grafts in it (ie with real commit object with a parent as 
> specified via the graft) but it doesn't - it just looses the graft and 
> rebrings all the old history back in
> 
> Is that a bug?

So far grafts were considered a private thing to enable some cool things
like tying ancient history to your current history tree, etc. But if you
want to do some persistent changes in the DAG, you are really best off
just rebuilding the whole history.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
