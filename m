From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 14:01:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609271358100.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
 <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com>
 <20060927080652.GA8056@admingilde.org>
 <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060927113813.GC8056@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 14:01:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSY6H-0004Nw-Js
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 14:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWI0MBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 08:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWI0MBO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 08:01:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:34975 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030189AbWI0MBO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 08:01:14 -0400
Received: (qmail invoked by alias); 27 Sep 2006 12:01:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 27 Sep 2006 14:01:12 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060927113813.GC8056@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27901>

Hi.

On Wed, 27 Sep 2006, Martin Waitz wrote:

> On Wed, Sep 27, 2006 at 11:55:22AM +0200, Johannes Schindelin wrote:
> > > My current approach is like this:
> > > 
> > >  * create a .gitmodules file which lists all the directories
> > >    which contain a submodule.
> > >  * the .git/refs/heads directory of the submodule gets stored in
> > >    .gitmodule/<modulename> inside the parent project
> > 
> > Taking this a step further, you could make subproject/.git/refs/heads a 
> > symbolic link to .git/refs/heads/subproject, with the benefit that fsck 
> > Just Works.
> 
> in fact it is done this way (more or less).

With the difference, that if you store the refs outside of 
<root>/.git/refs, you have to take extra care that prune does not delete 
the corresponding objects.

> > Nevertheless, you have to take care of the fact that you need to commit 
> > the state of the root project just after committing to any subproject.
> 
> why?
> 
> You can accumulate as many changes in different subprojects until you
> get to a state that is worth committing in the parent project.
> All these changes are then seen as one atomic change to the whole
> project.

AFAICT this is not the idea of subprojects-in-git. If you have to track 
the subprojects in the root project manually anyway, you don't need _any_ 
additional tool (you _can_ track files in a subdirectory containing a .git 
subdirectory).

Ciao,
Dscho
