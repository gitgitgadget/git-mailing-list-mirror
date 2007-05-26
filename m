From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW problem
Date: Sat, 26 May 2007 23:26:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705262318190.4648@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun May 27 00:27:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs4j1-0004GI-16
	for gcvg-git@gmane.org; Sun, 27 May 2007 00:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbXEZW05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 18:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbXEZW05
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 18:26:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:46706 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750823AbXEZW04 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 18:26:56 -0400
Received: (qmail invoked by alias); 26 May 2007 22:26:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 27 May 2007 00:26:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+D9u5DZVSDgmB4vmX4Mx8bR1Jwg9TQgk/e+JqnNT
	2o6xRWljKcFqwD
X-X-Sender: gene099@racer.site
In-Reply-To: <f3a2ke$9s7$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48497>

Hi,

On Sat, 26 May 2007, Han-Wen Nienhuys wrote:

> Johannes Sixt escreveu:
> >>
> >> http://lilypond.org/git/binaries/mingw/git-1.5.1-2.mingw.exe
> >>
> >> it should also set $PATH.
> > 
> > I gave this some more testing and it turns out to be a well working
> > toolset. Thank you very much!
> > 
> > There were still some issues remaining. These are the ones that should
> > be fixable easily:
> > 
> > * git version reports just:
> > 
> > 	git version -dirty
> > 
> > Since git-gui parses the output of git version, but does not expect it
> > to be of this format, and fails with an error message that it cannot
> > parse the version.
> 
> My biggest problem is that the makefiles of git are an unmitigated
> disaster, and there seems to be little interest in solving this
> problem. For example, my suggestion to introduce autoconf was met with
> derision.

Well, I would not call it derision. But many people have had bad 
experience with that big mess which is autoconf, so we were more than 
reluctant to do it.

In the meantime, we do have a configure.ac, though. In general, you do not 
have to run it, but you can if "make" does not work out of the box.

I have to admit that it is unclear to me what are the problems with the 
Makefile with regards to gub. I think I will just bite the apple, and 
download that beast to try it myself.

> In this, part of the pain is that Git tries to guess the version number
> by itself in a complicated way.

Yes, I never understood that myself why it has to be so complicated. But 
then, it did not make _my_ life hard, so I did not care.

> I thought the policy was to abandon Perl scripts for git commands?

Alas, no. We even have picked up a few since.

OTOH, it _is_ a nice thing to protohype the new commands as shell or perl 
scripts. When they stabilize enough, convert them to builtins.

There are exactly 4 perl scripts left that I regularly use:

add--interactive, cvsimport, remote and svn.

I somehow have the feeling that it is not worth the effort to convert 
cvsimport and svn. With add--interactive, I think it's better to leave it 
as is before Junio goes on another "what have I done? why did I have to 
add _this_?" spree.

But remote will soon be the center of my crosshairs.

Ciao,
Dscho
