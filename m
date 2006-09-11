From: Petr Baudis <pasky@suse.cz>
Subject: Re: Dropping Git.pm (at least Git.xs)?
Date: Mon, 11 Sep 2006 05:25:57 +0200
Message-ID: <20060911032557.GF23891@pasky.or.cz>
References: <7vodtxuqt4.fsf@assigned-by-dhcp.cox.net> <20060903150305.G50c94aea@leonov.stosberg.net> <4504529A.70401@vilain.net> <ee22lb$uia$1@sea.gmane.org> <7vodtxuqt4.fsf@assigned-by-dhcp.cox.net> <20060903150305.G50c94aea@leonov.stosberg.net> <4504529A.70401@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Stosberg <dennis@stosberg.net>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 05:26:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMcQv-0003cD-Sw
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 05:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWIKDZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 23:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWIKDZ7
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 23:25:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63682 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750700AbWIKDZ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 23:25:59 -0400
Received: (qmail 5789 invoked by uid 2001); 11 Sep 2006 05:25:57 +0200
To: Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ee22lb$uia$1@sea.gmane.org> <4504529A.70401@vilain.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26833>

Dear diary, on Sun, Sep 10, 2006 at 07:59:54PM CEST, I got a letter
where Sam Vilain <sam@vilain.net> said that...
> Dennis Stosberg wrote:
> > Having perl bindings to git internals and sometime in the future to a
> > libified git is a great thing.  It will allow people to do interesting
> > things, quickly trying concepts without having to write any C code.
> > And I expect that gitweb can be sped up remarkably by using Git.pm (no
> > forking, parsing of command output often not necessary, easy caching of
> > frequently cached data across calls, etc)
> 
> FWIW, I have been starting on a perl implementation.  It uses the
> Git.pm, but not for anything *that* important.  It's still very young,
> but once I have reading and writing files basically working, I'll
> release it to CPAN separately - no reason it needs to be distributed
> with Git itself.
> 
> See http://utsl.gen.nz/gitweb/?p=VCS-Git

I think those two can coexist quite well. Yours aims for a nice and
slick object interface, while mine is just about wrapping Git interface
in Perl, without building any elaborate object model (it would provide
any only if underlying libgit would in the future, I guess).

Now, I'm not actually opposed to making Git.pm provide more
object-oriented interface, and it is thus obvious that it might be due
to consider a merge of the two modules, but

  (i) Git.pm ought to stay bundled with Git, simply to be useful for Git
itself and the perl scripts it carries. Without Git.xs and associated
portability concerns, Git.pm might finally actually help things. :-)

  (ii) People would thus go mad about external dependencies like Moose
or even Class::Autouse, so Git.pm can't rely on anything like that
(unless it bundles it, which is not quite practical in case of Moose).

  (iii) (Besides, Moose may be the next totally cool and all-popular
thing in the world of Perl soon, but so far, I'd be personally careful
about using it for the "official" interface, since Git Perl developers
would apparently have to learn another way to do objects in Perl before
able to use Git, and other Perl developers going by couldn't read (and
fix/enhance) the code without doing the same.)


Dear diary, on Mon, Sep 11, 2006 at 12:13:01AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Could you please put appropriate information on GitWiki
>   http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
> Perhaps it would be good time to start new section, Git Implementations,
> and put egit (Java GIT library and Eclipse plugin) there too.

This really isn't a Git reimplementation (thankfully).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
