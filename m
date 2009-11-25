From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 12:43:55 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911251237000.2059@xanadu.home>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Mike Jarmy <mjarmy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 18:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDLuf-0001lc-Ev
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 18:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbZKYRoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 12:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759397AbZKYRoH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 12:44:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65336 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390AbZKYRnt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 12:43:49 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KTO00HMVEL7XN60@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Nov 2009 12:43:55 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133656>

On Wed, 25 Nov 2009, Mike Jarmy wrote:

> My question is this:  How do I manage a checkin for a bugfix that
> affects, say, only branches v3, v4, and v5?
> 
> Suppose that I checkout the v3 branch, and fix the bug by editing
> several different files.  (Lets assume for now that the files in
> question have not diverged between any of the 3 branches, even though
> tons of other files have changed).  How do I commit the bugfix into
> all of v3, v4 and v5?  Clearly, merging the branches together would be
> bad.  So I think what I should do is perform 3 different commits, but
> I'm not quite sure how to juggle the git index (or stash or whatever)
> to accomplish this.  This may be a really obvious question, but I'm a
> confused git newbie.

Besides what other people have already suggested, you might simply elect 
to use 'git cherry-pick' on the v4 and v5 branches to copy the fix from 
the v3 branch.

> Also, even though I may need to do 3 commits, it would be nice if the
> commits were related together in some way, since in a sense they
> represent only one action (namely, fixing the bug).  Is there a way to
> do that, so that its clear in gitk that it was really one unified
> thing? 

You can use the -x argument with 'git cherry-pick'.  This won't create a 
formal history graph but at least the commit log will record a reference 
to the original fix.


Nicolas
