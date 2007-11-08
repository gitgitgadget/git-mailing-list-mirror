From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Inconsistencies with git log
Date: Thu, 8 Nov 2007 13:28:58 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711081305010.29952@iabervon.org>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site> 
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> 
 <Pine.LNX.4.64.0711072255420.4362@racer.site> 
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> 
 <Pine.LNX.4.64.0711072309380.4362@racer.site>
 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 19:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqC8L-00050X-5c
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 19:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760451AbXKHS3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 13:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760798AbXKHS3T
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 13:29:19 -0500
Received: from iabervon.org ([66.92.72.58]:45675 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760451AbXKHS3T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 13:29:19 -0500
Received: (qmail 25294 invoked by uid 1000); 8 Nov 2007 18:28:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Nov 2007 18:28:58 -0000
In-Reply-To: <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64059>

On Wed, 7 Nov 2007, Jon Smirl wrote:

> On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Wed, 7 Nov 2007, Jon Smirl wrote:
> >
> > > On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > > We also tend to take the approach of viewing the history as that of
> > > > the whole project.
> > >
> > > But if you type 'git log' while cd'd into a subdirectory the whole log
> > > is almost never what you want. It's this kind of thing that makes git
> > > harder to use.
> >
> > When I am working in a subdirectory, I often want the whole history.  For
> > example, when I am working on the documentation, sometimes I need to look
> > up a commit real quick, that touched other parts.
> >
> > Besides, adding a space and a dot is not what qualifies for "harder to
> > use" with this developer.
> 
> So if git log is always whole tree, why doesn't this work?
> 
>  cd arch/powerpc/platforms/52xx
>  git log arch/powerpc/platforms/52xx
> fatal: ambiguous argument 'arch/powerpc/platforms/52xx': unknown
> revision or path not in the working tree.
> Use '--' to separate paths from revisions
> 
> It's not consistent. git log with no parameters is relative to the
> project root, git log with a parameter is relative to the current
> directory.

git log with no parameters is still relative to the current directory. 
It's just not limited by paths at all, so what it's relative to doesn't 
matter.

Since it shows is commits that change any of the given paths, the 
perfectly consistant thing to do without any paths would be to show no 
commits. Of course, that's totally useless, so we default to making no 
limitation instead.

If there were any other options that took paths or filenames, they'd be 
relative to the subdirectory, regardless of whether there were any paths, 
and having no paths would still show history for the project without 
regard to whether commits touch paths.

	-Daniel
*This .sig left intentionally blank*
