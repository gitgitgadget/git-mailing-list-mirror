From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Separating "add path to index" from "update content in index"
Date: Sun, 24 Dec 2006 16:38:17 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612241602060.20138@iabervon.org>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
 <7v64c7pmlw.fsf@assigned-by-dhcp.cox.net> <87wt4m2o99.wl%cworth@cworth.org>
 <7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net> <87vek62n1k.wl%cworth@cworth.org>
 <7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net> <87tzzp3fgh.wl%cworth@cworth.org>
 <slrneokplo.nsf.Peter.B.Baumann@xp.machine.xx> <7vbqlw92fw.fsf@assigned-by-dhcp.cox.net>
 <87d56cirs8.wl%cworth@cworth.org> <Pine.LNX.4.64.0612212337180.18171@xanadu.home>
 <878xgziog0.wl%cworth@cworth.org> <Pine.LNX.4.64.0612221709380.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <junkio@cox.net>,
	Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 22:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gyb32-0000hH-OU
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 22:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbWLXViW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 16:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbWLXViV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 16:38:21 -0500
Received: from iabervon.org ([66.92.72.58]:4867 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbWLXViV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 16:38:21 -0500
Received: (qmail 4836 invoked by uid 1000); 24 Dec 2006 16:38:17 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Dec 2006 16:38:17 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0612221709380.18171@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35375>

On Sat, 23 Dec 2006, Nicolas Pitre wrote:

> On Fri, 22 Dec 2006, Carl Worth wrote:
> 
> > On Fri, 22 Dec 2006 00:06:32 -0500 (EST), Nicolas Pitre wrote:
> > > On Thu, 21 Dec 2006, Carl Worth wrote:
> > >
> > > > So, I think what I really want here is a complete separation in the
> > > > interface between adding a path to the index and updating content into
> > > > the index.
> > >
> > > Strangely enough I think this separation is unnecessary and redundent.
> > 
> > One argument I would make in favor of the separation is that the two
> > operations are conceptually distinct from the user point-of-view. But
> > that's really hard to nail down since all users have different points
> > of view and different conceptual models,
> 
> ... and if we want to break the CVS model and give people a better 
> chance of ever grasping the git index concept I think they should not be 
> different.

I don't think the misunderstanding (if there is one) of the git index 
model is due to CVS. If I'm using a staging area for wrapping Christmas 
presents, I may assign space to items I haven't got yet: this is where I 
put the tape so I can reach it, this is where the roll of wrapping paper 
goes, here is where the wrapping paper will be spread out, but I can't 
spread out the wrapping paper until I have the present (it just rolls back 
up), so there's nothing in the spot allocated to actual wrapping. Git 
reminds me of people who have to put a trash can in their parking spaces 
when their cars aren't there to keep them from being deallocated simply 
because they're empty.

The allocation of empty space before anything is put in it is a 
fundamental operation available in the general concept of a staging 
area. Someone coming from an index-based version-control system that 
doesn't lack this feature would expect to have a possible status:

# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       new file: new-test-file
#

(And note that it can't be CVS-damage, because "Changed but not updated" 
isn't supported by CVS. This is a way in which git sort of has CVS-damage, 
because the "new file" operation goes straight to "Updated but not checked 
in", unlike everything else.)

	-Daniel
*This .sig left intentionally blank*
