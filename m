From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Fri, 29 Feb 2008 12:14:54 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802291211290.19665@iabervon.org>
References: <200802102007.38838.lenb@kernel.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org> <200802261438.17014.lenb@kernel.org> <7vir0byoc2.fsf@gitster.siamese.dyndns.org> <7voda2yksf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802271411280.19665@iabervon.org> <7vskzeruit.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802271605540.19665@iabervon.org> <20080228004313.GQ8410@spearce.org> <20080228085038.GS8410@spearce.org> <47C81A6B.1060905@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>, Len Brown <lenb@kernel.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 18:15:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV8pc-0002vv-Tm
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 18:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757620AbYB2RO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 12:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYB2RO5
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 12:14:57 -0500
Received: from iabervon.org ([66.92.72.58]:55651 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbYB2RO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 12:14:56 -0500
Received: (qmail 24067 invoked by uid 1000); 29 Feb 2008 17:14:54 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Feb 2008 17:14:54 -0000
In-Reply-To: <47C81A6B.1060905@freescale.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75543>

On Fri, 29 Feb 2008, Jon Loeliger wrote:

> Shawn O. Pearce wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > > Daniel Barkalow <barkalow@iabervon.org> wrote:
> 
> > > I agree its outside of 1.5.5, as we'd all like to see 1.5.5 happen
> > > soon, but it could be 1.5.6 material, especially if someone starts
> > > working on it sooner rather than later.
> > >
> > > Its actually probably not that difficult to implement.
> > 
> > OK, so I posted a fairly short series tonight (4 patches) that
> > handles some of the common cases in a fairly small amount of
> > code churn.  It might just be 1.5.5-ish.
> > 
> > Doing anything better is going to require a new protocol extension,
> > which is already 1.5.6 material.  In the mean time maybe Junio's
> > earlier patch to try and drop the ref_map when we do open the new
> > connection is the way to deal with the round-robin DNS issues.
> 
> 
> Hmmm... Might the any protocol extensions require a 1.6 release
> rather than a 1.5.x release?  Or is this extension compatible
> enough that it can be transparent?

The client and server exchange a list of supported features at the 
beginning, and the difference in behavior would be at the end, so it 
should be no problem to have the client ask for the chance to make further 
requests and the server acknowledge that (or the server offer and the 
client accept, depending on the order they do it, which I don't remember) 
without affecting programs that don't report the feature.

	-Daniel
*This .sig left intentionally blank*
