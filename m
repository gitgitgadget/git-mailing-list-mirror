From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RCS keyword expansion
Date: Thu, 11 Oct 2007 21:47:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710112144380.4174@racer.site>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Thu Oct 11 22:48:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig4wq-0005Ua-ND
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 22:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbXJKUrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 16:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173AbXJKUrv
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 16:47:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:34348 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755122AbXJKUru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 16:47:50 -0400
Received: (qmail invoked by alias); 11 Oct 2007 20:47:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 11 Oct 2007 22:47:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2OUBFGAi2aQwFDndgc+OIfDySlkaYvepKDCwPIq
	8kb+ntiBYpcoFb
X-X-Sender: gene099@racer.site
In-Reply-To: <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60634>

Hi,

On Thu, 11 Oct 2007, Oliver Kullmann wrote:

> On Thu, Oct 11, 2007 at 08:09:22AM -0700, Randal L. Schwartz wrote:
> > >>>>> "Peter" == Peter Karlsson <peter@softwolves.pp.se> writes:
> > 
> > Peter> I mainly want to have $Date$ expand in RCS/CVS manner, i.e to when the
> > Peter> file was last changed. Possibly even have an $Id$ that gives me
> > Peter> something useful (name and commit hash, perhaps?). Is it possible to do
> > Peter> this? Can it be done through git-cvsserver?
> > 
> > That's not a job for a source code manager to do.  It's a job for your
> > build/install tool.  See how "git --version" gets created in the core distro,
> > and follow that example.
> > 
> 
> This looks like a misunderstanding of what $Date$ is used for: It has 
> not much to do with a version number (such things are decisions by the 
> developers), but it is an identification stamp, typically used to 
> identify exactly which piece of code is involved in a given executable.

It does not matter if it is a date or a version number.

The problem is this: for efficiency, git does not change files which have 
not changes between the last version checked out (whatever that is) and 
the current version.

This seems counterintuitive to people coming from SVN/CVS: they expect 
_every_ file to be touched when checking out.

So there is not much we will do to accomodate in git; touching files which 
have not changed at all (even if containing a $Id$ or a $Date$) is not the 
way we want it...

As Randal already suggested: if you need something like this, you better 
have a build procedure which replaced $Date$ _at a given time_ (make 
install) with the current date.

Ciao,
Dscho
