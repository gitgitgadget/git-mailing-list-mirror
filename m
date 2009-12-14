From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] Bad msysgit/egit interaction over dotfiles
Date: Mon, 14 Dec 2009 12:45:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912141241000.4985@pacific.mpi-cbg.de>
References: <20091208132857.GB5425@linagora.com>  <40aa078e0912080534x32fe9724xcda47ad46dbdb7c0@mail.gmail.com>  <4B1E57BF.1000500@pelagic.nl>  <40aa078e0912080623q108b2affk80534ccd5fd7ace3@mail.gmail.com>  <20091208143700.GC5425@linagora.com>
 <4B200EF5.2060606@gmail.com>  <20091210083514.GA5971@linagora.com> <40aa078e0912140113w23823058h4ca691963761d3be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1666513806-1260791110=:4985"
Cc: Yann Dirson <ydirson@linagora.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>,
	GIT ml <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 12:40:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK9I6-0001jW-SH
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 12:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754AbZLNLke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 06:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756292AbZLNLke
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 06:40:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:54908 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756091AbZLNLkd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 06:40:33 -0500
Received: (qmail invoked by alias); 14 Dec 2009 11:40:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 14 Dec 2009 12:40:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BDtAZGkGB9hpKOdF+1VGy/DYn8GDBQNKj6oRhoW
	/WrCjVzWOETD46
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <40aa078e0912140113w23823058h4ca691963761d3be@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135201>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1666513806-1260791110=:4985
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 14 Dec 2009, Erik Faye-Lund wrote:

> On Thu, Dec 10, 2009 at 9:35 AM, Yann Dirson <ydirson@linagora.com> wrote:
>
> > [discussion revolving around ".*" being marked hidden on Windows]
> >
> > But maybe the situation is not so clear.  That "hide dotfiles" was 
> > implemented so that ".git" at first, and then ".git*" files do not 
> > clutter the view of the project.  But then, if a git repo has other 
> > dotfiles, those are really *part of* the versionned stuff, so I do not 
> > see why those should be hidden at all.  After all, the .project, 
> > .classpath, and other eclipse project files have that name on windows 
> > too, and it will indeed *confuse* people to get them hidden.
> >
> > So should we have 2 classes of dotfiles, those "private to git", and
> > the others, one class being hidden while the others are not ?  I am
> > not sure at all this would be a good idea either.  Or maybe we should
> > only get .git hidden - after all, that one is the only real metadata
> > not part of the versionned stuff itself ?
> >
> > Maybe we should add some sort of "core.hidedotfiles = dotgitonly"
> > setting, and make that the default ?  That one does not appear to
> > cause any problems to jgit, and eclipse itself has not business with
> > it, so it would IMHO make sense.
> >
> > Opinions ?
> >
> 
> IF we were to go down this path, perhaps it would be even better to
> use some sort of file-pattern or even squeeze this into gitattributes?
> I guess something like ".* +hidden" should emulate the unix behaviour
> (given that we add a hidden attribute). I don't think we have a global
> gitattributes file though, so it'd have to be added to each repo where
> the effect is desired, I guess.

Actually, I think the original request was really for all the dot files, 
not just for .git.

But I can see the reasoning behind hiding only .git, which I would not 
like to make the default, though.  I would like to make Eclipse users set 
this explicitely in their /etc/gitconfig (possibly via the Git for Windows 
installer, just like the infamous -- and still broken -- core.autocrlf 
setting, if Sebastian is nice enough to make yet another page in the 
installer).

So: I would definitely take a patch implementing "core.hidedotfiles = 
dotgitonly", but would hesitate to make it the default.

Ciao,
Dscho

--8323328-1666513806-1260791110=:4985--
