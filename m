From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Re: Add "clone" support to lntree
Date: Tue, 19 Apr 2005 03:12:07 +0200
Message-ID: <20050419011206.GT5554@pasky.ji.cz>
References: <20050416233305.GO19099@pasky.ji.cz> <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 03:08:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhE5-00079k-HD
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVDSBMY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVDSBMY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:12:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17587 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261245AbVDSBMK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 21:12:10 -0400
Received: (qmail 30293 invoked by uid 2001); 19 Apr 2005 01:12:07 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

For the record, mostly... (this is how it already is in git-pasky-0.5)

Dear diary, on Sun, Apr 17, 2005 at 02:07:36AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > Now, what about git branch and git update for switching between
> > branches? I think this is the most controversial part; these are
> > basically just shortcuts for not having to do git fork, and I wouldn't
> > mind so much removing them, if you people really consider them too ugly
> > a wart for the soft clean git skin. I admit that they both come from a
> > hidden prejudice that git fork is going to be slow and eat a lot of
> > disk.
> 
> I think that this just confuses matters.

I killed them both for good.

> > The idea for git update for switching between branches is that
> > especially when you have two rather similar branches and mostly do stuff
> > on one of them, but sometimes you want to do something on the other one,
> > you can do just quick git update, do stuff, and git update back, without
> > any forking.
> 
> I still think that fork should be quick enough, or you could leave the
> extra tree around. I'm not against having such a command, but I think it
> should be a separate command rather than a different use of update, since
> it would be used by poeople working in different ways.

I've removed git branch, removed the possibility for git update to
switch branches and renamed git update to git seek. You can do

	git seek git-pasky-0.1

and examine stuff, but your tree is also blocked at the same time - git
won't let you commit, merge and such. By doing

	git seek
or
	git seek master

you return back to your branch (assuming its name is master).

I think git fork is after all good enough for branching and it is the
clean way. Shall there be a big demand for it, it should be minimal
hassle to implement 'git switch', which would do that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
