From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 7/9] Export create_branch() from builtin-branch.c
Date: Tue, 5 Feb 2008 15:39:02 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802042139170.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041336010.13593@iabervon.org> <alpine.LSU.1.00.0802050136440.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:39:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMUa2-00046i-8Q
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758787AbYBEUjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758737AbYBEUjH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:39:07 -0500
Received: from iabervon.org ([66.92.72.58]:48624 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758656AbYBEUjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:39:05 -0500
Received: (qmail 9481 invoked by uid 1000); 5 Feb 2008 20:39:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2008 20:39:02 -0000
In-Reply-To: <alpine.LSU.1.00.0802050136440.8543@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72694>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> 
> > You can also create branches, in exactly the same way, with checkout -b.
> > 
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> >  builtin-branch.c |    4 ++--
> >  cache.h          |    4 ++++
> 
> Note that builtin-branch.c is not part of libgit.a, so you are only moving 
> the declaration into the "libgit" part.
> 
> Maybe it would be better to move this function, say, into refs.c?

I think it's actually time to start a branch.{c,h} library file for 
operations that deal with the porcelain-ish information about branches. 
This would go there, and a function to discard MERGE_HEAD and similar 
files (whatever they are, which isn't currently collected anywhere 
authoritative). Probably also most of the other stuff that should be 
shared between reset and checkout, too, and functions should probably 
migrate there from builtin-branch and builtin-checkout as they become 
needed, leaving the builtin-* code as command-line parsing and calls to 
these functions. In any case, I'll start with this.

	-Daniel
*This .sig left intentionally blank*
