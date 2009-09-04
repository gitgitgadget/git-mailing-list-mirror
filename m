From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
 case
Date: Sat, 5 Sep 2009 00:36:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909050023240.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>  <fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com>  <alpine.LNX.2.00.0909041114440.28290@iabervon.org> <7vy6ouk4io.fsf@alter.siamese.dyndns.org>  <alpine.DEB.1.00.0909041930450.8306@pacific.mpi-cbg.de>
 <alpine.LNX.2.00.0909041429540.28290@iabervon.org> <fabb9a1e0909041235x74a3b9b4gf65e650ca0d00831@mail.gmail.com> <alpine.DEB.1.00.0909042305390.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0909041750390.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2142479076-1252103801=:8306"
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 00:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjhNU-0005Kj-A0
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 00:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934415AbZIDWfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 18:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934407AbZIDWfS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 18:35:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:45238 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934398AbZIDWfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 18:35:16 -0400
Received: (qmail invoked by alias); 04 Sep 2009 22:35:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 05 Sep 2009 00:35:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XeacCCHyX5ZDq2SdZZP/gu6EkqHwzZFS21th3fJ
	3xkESRKx6c2w8i
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0909041750390.28290@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127771>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2142479076-1252103801=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 4 Sep 2009, Daniel Barkalow wrote:

> On Fri, 4 Sep 2009, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Fri, 4 Sep 2009, Sverre Rabbelier wrote:
> > 
> > > On Fri, Sep 4, 2009 at 21:05, Daniel Barkalow<barkalow@iabervon.org> 
> > > wrote:
> > > > Some foreign vcses, including the only one I ever personally use, do 
> > > > not have URLs, and require a bunch of options and paths to specify a 
> > > > repository. I don't want to have to use:
> > > >
> > > >        url = p4://rsh:ssh+-q+-a+-x+-l+p4ssh+-q+-x+perforce+%2Fbin%2Ftrue//projects/foo/bar-1.0/...,//projects/foo/bar-1.1/...
> > > 
> > > Btw, doesn't p4 have these config files that you can download that 
> > > contain the configuration? In that case 
> > > 'p4://example.org/p4/main-development.configfile' would be very 
> > > convenient.
> > 
> > If that's how p4 users initialize their working directories, then that is 
> > the way to go.
> > 
> > And I cannot start to believe that the complicated way you described is 
> > the common way to initialize p4 working directories, as that would tempt 
> > the intelligence/enthusiasm of the average programmer.
> 
> Perforce is probably the single most popular system for git to import 
> from because it is such a monumental pain to use for anything at all 
> that it's easier to learn git, write a git importer, and use your git 
> importer than it is to actually use Perforce directly.
> 
> Of course, it's not really beyond the average programmer to get a p4 
> working directory, because whoever is running the server will have > 
> provided a file to copy and instructions on setting an environment 
> variable.

That is what we need to optimize for, then.

> They don't know what the magic formula means; they just use it. And they 
> only work on one branch until that branch is done with, and then they 
> throw away that working directory, get a new working directory, and 
> never look at the other branch's history again (and certainly never 
> track anything across branches). Also, they have p4 experts who deal 
> with merging branches so that stuff doesn't get lost when moving to a 
> new branch. And the experts have scripts built into the release process 
> that attempt to insure that things don't get lost. The reason that my 
> helper can't have a single location for a repository is that the 
> branches of a single project are strewn randomly about the namespace, 
> and a proper git import needs to know what to stitch into a single 
> repository.

And why not having the different branches which are strewn randomly about 
the namespace as separate remotes for a Git repository?  After all, the 
average p4 user will be wanting to work on _one_ branch, as you so aptly 
described.

> For the matter of where the server is, Perforce supports just having a 
> "server:port" value, but if the organization uses this, there's no 
> authentication of users possible. Instead, organizations set up an ad 
> hoc collection of ssh proxies and give people a string which is the 
> command to go through those proxies, because Perforce only knows how to 
> use rsh or a command you provide that acts like rsh.

That explains a tiny part of the long path you provided, but certainly not 
all (I am especially curious what /bin/true thinks it's doing in that 
URL).

If what you said about ssh is true, then it should be the same type of 
invocation everywhere, and it should certainly be very easy to provide a 
shortcut for that URL; no need for the _user_ (who could not care less how 
ssh happens to be called) to remember.

Something like "git clone p4::ssh://p4ssh@projects/foo/bar-1.0/..." should 
become a very easy and intuitive way for the average programmer to clone a 
p4 branch into a Git repository.

Should the developer ever need to work with another branch of the same 
project, very easy:

	$ git remote add -f bar-1.1 p4::ssh://p4ssh@projects/foo/bar-1.1/...
	$ git checkout -b my-1.1 bar-1.1/master

Now, I am not married to having more than one remote for multiple 
branches, but there is _no_ reason why this has to be done at clone time, 
if the average p4 user does not do that either.  You can always teach 
git-remote-p4 to behave sensibly and ask the user to

	$ git config --add remote.origin.fetch \
		+/foo/bar-1.1:refs/remotes/origin/bar-1.1

Note, these are two alternative suggestions.  I am not trying to decide 
what is better here, but I am convinced that both options are more 
intuitive than the "vcs" variable.

Ciao,
Dscho

--8323328-2142479076-1252103801=:8306--
