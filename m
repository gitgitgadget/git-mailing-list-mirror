From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 9/9] Build in checkout
Date: Tue, 5 Feb 2008 20:04:11 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802051958440.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041336060.13593@iabervon.org> <alpine.LSU.1.00.0802050143050.8543@racer.site> <alpine.LNX.1.00.0802042201060.13593@iabervon.org> <alpine.LSU.1.00.0802052205210.8543@racer.site> <alpine.LNX.1.00.0802051716220.13593@iabervon.org>
 <alpine.LSU.1.00.0802052244160.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 02:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYiT-0000av-LT
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 02:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430AbYBFBEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 20:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757774AbYBFBEN
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 20:04:13 -0500
Received: from iabervon.org ([66.92.72.58]:53164 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbYBFBEM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 20:04:12 -0500
Received: (qmail 22625 invoked by uid 1000); 6 Feb 2008 01:04:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 01:04:11 -0000
In-Reply-To: <alpine.LSU.1.00.0802052244160.8543@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72739>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 5 Feb 2008, Daniel Barkalow wrote:
> 
> > On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> > 
> > > I suggested that: to prevent the index from needing an update.
> > > 
> > > This is quite important if you have a large working tree, and switch 
> > > branches from A to B.  For example, "make" will punish you where it 
> > > hurts.
> > 
> > This isn't used for switching branches; this is used for checking out 
> > paths. If you do "git checkout <not-head> -- <every single path>", make 
> > will punish you, but why would you do that? I'd guess that people are 
> > unlikely to have a significant number of non-changes in this piece of 
> > code, just because they wouldn't list things that they didn't think had 
> > changes.
> 
> For convenience, you can also say
> 
> 	$ git checkout -- <path>
> 
> and expect checkout to not really touch the unchanged files.

That also doesn't use this function, which is only for reading the tree 
into the index if a tree is given. On the other hand:

$ git checkout HEAD -- .

With either git-checkout.sh or my code, touches all of your files.

	-Daniel
*This .sig left intentionally blank*
