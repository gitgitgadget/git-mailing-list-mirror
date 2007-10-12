From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 11:02:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710121057540.25221@racer.site>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
 <Pine.LNX.4.64.0710112144380.4174@racer.site>
 <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Oct 12 12:02:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgHLu-0001Nh-Op
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 12:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759510AbXJLKCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 06:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759431AbXJLKCc
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 06:02:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:53415 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759510AbXJLKCb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 06:02:31 -0400
Received: (qmail invoked by alias); 12 Oct 2007 10:02:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 12 Oct 2007 12:02:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++IJ5KDXS+ZOPVNqhsjbvcQyNaNIMzyuv8NT0RsA
	gVyKyMjuMdUYkv
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60669>

Hi Peter,

please do not play games with the To: header.  We have a policy here 
(which is supposed to be good netiquette) that we keep people in the Cc: 
list that we respond to.

On Fri, 12 Oct 2007, Peter Karlsson wrote:

> Johannes Schindelin:
> 
> > The problem is this: for efficiency, git does not change files which 
> > have not changes between the last version checked out (whatever that 
> > is) and the current version.
> > 
> > This seems counterintuitive to people coming from SVN/CVS: they expect 
> > _every_ file to be touched when checking out.
> 
> No? That would just be strange. Only the files that are actually changed 
> should be updated, no others. A $Date$ or $Id$ will show the last 
> time/commit that specific file was changed, not the latest global state 
> (I guess the fact that most modern VCSs have global state makes this a 
> bit more difficult to achieve, in RCS/CVS/PVCS and others the change 
> history is local to a file and thus it is trivial to find the large 
> change for that particular file).

But don't you see?  When switching branches, this totally breaks down.  
No, really, IMHO it is enough to show either the commit name or the blob 
name of the file.  After all, you are not interested in the date that this 
file was last committed, but in the _contents_.

So why not go for the contents?  With CVS/SVN you only have the chance to 
do that by date or version number.  With git, we have a more powerful way: 
we do it by a hash of the contents.

> > As Randal already suggested: if you need something like this, you 
> > better have a build procedure which replaced $Date$ _at a given time_ 
> > (make install) with the current date.
> 
> But that's not what I want. Then my build procedure would need to do a 
> "git status", or whatever you use to get the last commit information 
> about a file, on each file that is changed and is to be installed. It 
> would be a lot easier if that was done already on checkout through some 
> kind of hook.

If it's not what you want, I suggest rethinking what you want ;-)

Otherwise it is scripting time for you.  It's easy enough with git.

Ciao,
Dscho
