From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git BOF notes
Date: Sat, 22 Jul 2006 05:55:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607220547570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060719230155.GJ13776@pasky.or.cz> <20060721131824.GC32585@fieldses.org>
 <20060721144249.GO13776@pasky.or.cz> <Pine.LNX.4.63.0607220212140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060722032200.GP13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 22 05:56:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G48b1-0001EY-ST
	for gcvg-git@gmane.org; Sat, 22 Jul 2006 05:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWGVD4C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 23:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWGVD4B
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 23:56:01 -0400
Received: from mail.gmx.de ([213.165.64.21]:29583 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751286AbWGVD4A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jul 2006 23:56:00 -0400
Received: (qmail invoked by alias); 22 Jul 2006 03:55:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 22 Jul 2006 05:55:59 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060722032200.GP13776@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24064>

Hi,

On Sat, 22 Jul 2006, Petr Baudis wrote:

>   Hi,
> 
> Dear diary, on Sat, Jul 22, 2006 at 02:17:48AM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > On Fri, 21 Jul 2006, Petr Baudis wrote:
> > 
> > > Yes, there is some blury stuff, but I think it's rather a sign that
> > > something is missing in the core Git porcelain. git-init-db is lowlevel
> > > and I think in 99% of the cases you are going to do an initial commit
> > > right after anyway, so you might as well just get git-init which does it
> > > for you (something akin cg-init ;).
> > 
> > Think "changed templates".
> 
>   it may be that I'm just tired, but I don't see what you mean, sorry.

If you change a template (like add a hook or something), you can call 
git-init-db in an existing repository to update that hook.

> > And also think "setup a remote repository", especially "setup a remote
> > HTTP repository".
> 
>   Of course. Currently you need to tinker with environment variables,
> then with hooks, possibly with permissions and stuff to make the
> repository shared... Think cg-admin-setuprepo. ;-)

git-init-db --shared

> > And also think "start a new repository with only a _part_ of the current 
> > files". There are plenty reasons -- in addition to separation of concepts 
> > -- not to commit straight after initializing a repository.
> 
>   So what _do_ you do if you don't commit straight?

Sometimes, I do "git-push just@initted.repository.com master". From 
somewhere else, of course.

At other times, I do "git-add the-paper.tex && git commit initial".

And sometimes, I do "cp -R /some/where/CVS ./; git-cvsimport".

>   Of course sometimes you don't want to add everything, and that should
> still be possible to do (cg-init has a switch for that).

Usually I start small projects as a single .c or .java file. Only after a 
while, I think it is worth it to init a git database. So, I _always_ have 
generated files lying around. And I would hate it if they were checked in 
automatically. (Yeah, I could remove them, _then_ remove them from the 
index, and then git-commit --amend. Ugly.)

> > > I think we still tell users to use git-update-index to mark resolved 
> > > conflicts, [...]
> > 
> > I don't know, but I had the impression we'd tell them "resolve your 
> > conflicts, and then do git-commit -a". Which is good enough.
> 
>   My comment there was based on the jdl's presentation at OLS. Sorry if
> in docs we are saying other things, I don't tend to lookat Git porcelain
> documentation. ;-)

That makes two of us.

Ciao,
Dscho
