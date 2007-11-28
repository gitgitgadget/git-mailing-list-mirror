From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 17:48:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711281702140.5349@iabervon.org>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> 
 <7vmyszb39s.fsf@gitster.siamese.dyndns.org> 
 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com> 
 <20071128092234.GA12977@diana.vm.bytemark.co.uk>
 <9e4733910711280713n6b439866m55bea4824efd959@mail.gmail.com>
 <Pine.LNX.4.64.0711281600320.5349@iabervon.org> <795F24E6-9145-4007-95EB-DB63D9F6295A@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxViS-0006yA-UG
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbXK1Wsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757468AbXK1Wsw
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:48:52 -0500
Received: from iabervon.org ([66.92.72.58]:42461 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755761AbXK1Wsw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:48:52 -0500
Received: (qmail 6931 invoked by uid 1000); 28 Nov 2007 22:48:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Nov 2007 22:48:50 -0000
In-Reply-To: <795F24E6-9145-4007-95EB-DB63D9F6295A@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66450>

On Wed, 28 Nov 2007, Steven Grimm wrote:

> On Nov 28, 2007, at 1:47 PM, Daniel Barkalow wrote:
> >(That is, "git rebase -i" seems
> >to work fine for making changes to a single logical patch series, all of
> >whose patches are prepared locally and aren't independantly named in some
> >particular fashion; the things that aren't handled are "I need to replace
> >the pull of netdev.git with a new pull of netdev.git" or "I need to
> >replace '[PATCH] fix-the-frobnozzle-gadget' with
> >'[PATCH v2] fix-the-frobnozzle-gadget'.)
> 
> I use rebase -i for that last case and it works fine -- I mark the appropriate
> commit as "edit" in the patch list and the rebase stops there, at which point
> I can update the patch in any way I see fit: tweak it a bit, replace it with a
> different change entirely, change the commit message, etc. What's missing from
> rebase -i in that respect? I guess it's not as easy to script for automated
> patch replacement.

Just that you have to find the patch yourself and replace it; if you're 
doing this a lot, you'll want to say "here's a new version of 
fix-the-frobnozzle-gadget, do the right thing". Also, for series items 
that are pulling some remote tree, you want it to remember the info, so 
you can just say "pull git-netdev" and have it fetch the latest from the 
appropriate remote and replace the merge commit with a new merge commit.

I think that people in this role using quilt do it by: "quilt pop -a; 
replace the patch file without looking at the series file; quilt push 
-a"; in the (hopefully) common case, you don't have to worry about any of 
the details, which is why the task remains tractable.

	-Daniel
*This .sig left intentionally blank*
