From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git ready: daily git tips
Date: Tue, 10 Feb 2009 11:19:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101117320.10279@pacific.mpi-cbg.de>
References: <1234131508141-2294642.post@n2.nabble.com> <alpine.LFD.2.00.0902091524520.30940@xanadu.home> <slrngp1ljg.cnd.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 11:20:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWpiy-0003Sj-Ee
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 11:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbZBJKSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 05:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbZBJKSs
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 05:18:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:44281 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752433AbZBJKSr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 05:18:47 -0500
Received: (qmail invoked by alias); 10 Feb 2009 10:18:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 10 Feb 2009 11:18:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/H5f1n6JXHKWcc+kxtQjm8NCJZPPCtfpdvNna3Se
	EmRy18ArKWYoFw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <slrngp1ljg.cnd.sitaramc@sitaramc.homelinux.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109194>

Hi,

On Tue, 10 Feb 2009, Sitaram Chamarty wrote:

> On 2009-02-09, Nicolas Pitre <nico@cam.org> wrote:
> > On Sun, 8 Feb 2009, Nick Quaranto wrote:
> >> http://gitready.com
> >
> > Well done.
> >
> > One topic that IMHO you fail to cover, and which is being neglected 
> > almost everywhere else too, is the reflog.
> >
> > The reflog is really your safety net when working with git.  It records 
> > everything you do. So even if you screw up a rebase, perform the wrong 
> > merge, or any other kind of undesired operation, then you may always go 
> > back to a previous state.  Either you use -g with 'git log' to see all 
> > those recorded states, or even 'git reflog' without any argument to get 
> > a condensed list for HEAD.
> >
> > The <branch>@{<spec>} notation can be used anywhere a ref is normally 
> > required.  The special branch "HEAD" shows every state the HEAD pointer 
> > went through, including branch switches.  The <branch< part can be left 
> > out to mean "currently checked-out branch".
> >
> > One thing that I use all the time after a 'git pull' is 'git log @{1}..' 
> > where "@{1}" means the first previous tip of the current branch, so 
> > effectively showing me the log of what the pull brought in my branch.
> 
> Also, the @{now} notation to get a relative timestamp of the
> reflog is invaluable.  Seeing reflog lines annotated with
> '14 minutes ago' or '17 hours ago' or perhaps '4 days ago',
> really helps to focus on the commits you're looking for:
> 
>     git reflog show @{now}
>     # (the 'show' is not optional in this syntax)

Yes, I often use "git log -g --date=relative" to get a better 
understanding of my recent actions in that particular repository.

Also do not forget to advertise the new @{-<n>} notation for the n-th last 
branch you were on (to be part of 1.6.2 AFAIU).  This comes in really 
handy when you juggle a dozen branches (and happen to commit to the wrong 
branch ;-)

Ciao,
Dscho
