From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Notes on Using Git with Subprojects
Date: Thu, 28 Sep 2006 17:39:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609281738120.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
 <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com>
 <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com>
 <20060927173335.GC2807@coredump.intra.peff.net> <451B45D6.1010006@gmail.com>
 <20060928035238.GC22897@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: A Large Angry SCM <gitzilla@gmail.com>, Jeff King <peff@peff.net>,
	Martin Waitz <tali@admingilde.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 17:39:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSxz0-0001lX-Jm
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 17:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWI1PjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 11:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWI1PjT
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 11:39:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:1256 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965158AbWI1PjS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 11:39:18 -0400
Received: (qmail invoked by alias); 28 Sep 2006 15:39:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 28 Sep 2006 17:39:16 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060928035238.GC22897@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28008>

Hi,

On Wed, 27 Sep 2006, Shawn Pearce wrote:

> A Large Angry SCM <gitzilla@gmail.com> wrote:
> > Jeff King wrote:
> > [...]
> > >One thing that I believe some people have requested for subprojects is
> > >to avoid downloading files/history for subprojects you're not interested
> > >in.  I think this could be faciliated in this scheme by only cloning the
> > >heads of the subprojects you're interested in (there would need to be
> > >special machinery to handle this at the root level if we want to allow
> > >making root commits without necessarily having all of the subprojects).
> > 
> > In what I'm suggesting, commits are local to a project's working 
> > directory repository and are pushed somewhere else to be recorded long 
> > term. Since projects are stand alone, possibly with dependencies, 
> > working on a (sub)project without having other associated (sub)projects 
> > is accomplished by checking it out.
> > 
> > >A first step to this would be an argument to git-clone to allow cloning
> > >only a subset of refs.
> > 
> > Something like this?
> > 
> > 	git-init-db
> > 	git-fetch <repository> <refspecs>
> 
> More like:
> 
>  	git-init-db
>  	git-fetch --keep <repository> <refspecs>
> 
> but yes.  :-)

You are missing the remotes/ information:

git-repo-config remote.origin.url <repository>
for spec in <refspecs>; do
	git-repo-config remote.origin.fetch $spec ^$
done

Ciao,
Dscho
