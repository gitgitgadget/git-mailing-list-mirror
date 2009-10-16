From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 14:29:15 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910161340140.32515@iabervon.org>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151523020.32515@iabervon.org> <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet> <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 16 20:29:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyrYW-0002Io-Ex
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 20:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbZJPS3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 14:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbZJPS3M
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 14:29:12 -0400
Received: from iabervon.org ([66.92.72.58]:34028 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbZJPS3L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 14:29:11 -0400
Received: (qmail 2121 invoked by uid 1000); 16 Oct 2009 18:29:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Oct 2009 18:29:15 -0000
In-Reply-To: <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130518>

On Fri, 16 Oct 2009, Julian Phillips wrote:

> It was the approach that I was trying to suggest rather than the actual
> commands.  The point I was trying to make was how, as a user, I would be happy
> to git behave.
> 
> So, I try to run fetch, git says "ooh, now that would be dangerous - you can
> force it happen by running "git foo", but you will then be in situation X,
> which you can then recover from by running "git bar", though you may need to
> run "git stash" to save any edits you have made" or something similar.
> 
> Now as a user I know that I have tried to do something a bit unusual, but I
> don't have to run to the mailing list or #git saying "I just did X Y Z and
> everything is now FUBARed".  I can even proceed to do the unusal thing, as git
> itself has given me the information I need to sort things out afterwards.

The thing is that that sequence shouldn't be unusual or dangerous or 
require sorting things out afterwards. In the current version of git, it's 
a completely normal thing to do that behaves nicely and does what the user 
almost certainly wants. We *could* horribly break it, and then add 
messages to tell the user they're doing something that's now horribly 
broken, and tell the user how to cope with the fact that what they want to 
do involves something that's horribly broken, and roll our eyes when users 
who have only used working systems like SVN or git 1.6.X ignore the 
message and can't figure out what's going on. Or we could just not break 
it in the first place.

SVN doesn't think that your working directory is supposed to change when 
someone else makes a commit. Git shouldn't think your working directory 
should change when you find out that someone made a commit. If you want to 
see now commits, you do "svn up" or "git checkout".

	-Daniel
*This .sig left intentionally blank*
