From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Wed, 20 Apr 2005 23:15:05 +0200
Message-ID: <20050420211505.GE19112@pasky.ji.cz>
References: <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org> <20050419011206.GT5554@pasky.ji.cz> <42646967.9030903@dwheeler.com> <4264CCFF.30400@dgreaves.com> <20050419092812.GE2393@pasky.ji.cz> <1113905110.1262.1.camel@nosferatu.lan> <20050419105008.GB12757@pasky.ji.cz> <20050420070157.GA12584@elte.hu> <20050420200504.GB19112@pasky.ji.cz> <20050420203235.GA13270@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	David Greaves <david@dgreaves.com>, dwheeler@dwheeler.com,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 23:12:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOMTh-0006TI-IT
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 23:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDTVPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 17:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVDTVPb
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 17:15:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7390 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261798AbVDTVPI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 17:15:08 -0400
Received: (qmail 3051 invoked by uid 2001); 20 Apr 2005 21:15:05 -0000
To: Ingo Molnar <mingo@elte.hu>
Content-Disposition: inline
In-Reply-To: <20050420204551.GA13944@elte.hu> <20050420203235.GA13270@elte.hu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 10:32:35PM CEST, I got a letter
where Ingo Molnar <mingo@elte.hu> told me that...
> 
> * Petr Baudis <pasky@ucw.cz> wrote:
> 
> > > yet another thing: what is the canonical 'pasky way' of simply nuking 
> > > the current files and checking out the latest tree (according to 
> > > .git/HEAD). Right now i'm using a script to:
> > > 
> > >   read-tree $(tree-id $(cat .git/HEAD))
> > >   checkout-cache -a
> > > 
> > > (i first do an 'rm -f *' in the working directory)
> > > 
> > > i guess there's an existing command for this already?
> > 
> > git cancel
> 
> hm, that's a pretty unintuitive name though. How about making it 'git 
> checkout' and providing a 'git checkout -f' option to force the 
> checkout? (or something like this)

Since it does not really checkout. Ok, it does, but that's only small
part of it. It just cancels whatever local changes are you doing in the
tree and bring it to consistent state. When you have a merge in progress
and after you see the sheer number of conflicts you decide to get your
hands off, you type just git cancel. Doing basically anything with your
tree (not only local changes checkout would fix, but also various git
operations, including git add/rm and git seek) can be easily fixed by
git cancel.

Dear diary, on Wed, Apr 20, 2005 at 10:45:51PM CEST, I got a letter
where Ingo Molnar <mingo@elte.hu> told me that...
> 
> * Petr Baudis <pasky@ucw.cz> wrote:
> 
> > Dear diary, on Wed, Apr 20, 2005 at 09:01:57AM CEST, I got a letter
> > where Ingo Molnar <mingo@elte.hu> told me that...
> > >  [...]
> > >  fatal: unable to execute 'gitmerge-file.sh'
> > >  fatal: merge program failed
> > 
> > Pure stupidity of mine, I forgot to add gitmerge-file.sh to the list of
> > scripts which get installed.
> 
> another thing is this annoying message:
> 
>  rsync: link_stat "/linux/kernel/people/torvalds/git.git/tags" (in pub) 
>  failed: No such file or directory (2)
>  rsync error: some files could not be transferred (code 23) at 
>  main.c(812)
>  client: nothing to do: perhaps you need to specify some filenames or 
>  the --recursive option?
> 
> you said before that it's "harmless", but it's annoying nevertheless as 
> one doesnt know for sure whether the pull went fine.

Already fixed. (Well, "fixed"... sent to /dev/null. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
