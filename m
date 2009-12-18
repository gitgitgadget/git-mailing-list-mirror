From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Thu, 17 Dec 2009 22:33:03 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912172149020.23173@xanadu.home>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
 <20091215023918.GA14689@coredump.intra.peff.net>
 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
 <1260851180.9379.88.camel@localhost>
 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
 <1260970885.2788.87.camel@localhost>
 <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
 <1261003041.2788.142.camel@localhost>
 <alpine.LFD.2.00.0912161841210.23173@xanadu.home>
 <1261067369.2868.10.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 04:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLTae-0008PH-7F
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 04:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbZLRDdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 22:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbZLRDdJ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 22:33:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41215 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbZLRDdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 22:33:08 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KUT003E0WJ3MWJ0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Dec 2009 22:33:04 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1261067369.2868.10.camel@localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135396>

On Thu, 17 Dec 2009, Eric Paris wrote:

> This alone almost certainly tells me how I broke it.
> 
> For quite some time (a period of months) linux-next was broken and I had
> to carry a patch to ACPI to make it boot.  I dropped that patch at the
> head of my stgit trees in all of my repositories.  So I wouldn't be at
> all surprised to learn that eventually kernel-2 found that object in
> kernel-1.  Sometime when I dropped that patch from kernel-1 (because it
> finally got fixed upstream) I can see how it broke.
> 
> But now that patch shouldn't be needed by any tree since I have long
> since dropped it from the stgit stack.  So if we cleaned up all of the
> useless objects in this tree I bet this object wouldn't be needed.  Not
> exactly a situation that I'd expect git to be able to dig out of itself
> thought.

I let the script I provided previously ran for a while.  And the commit 
I found to contain the missing object belongs to 
refs/patches/fsnotify/fsnotify-group-priorities.log.  So I simply 
deleted that branch entirely and now the repack can proceed.  And with a 
'git gc --aggressive' the 1.2GB repository shrank to a mere 5.2 MB.  :-) 
Of course I didn't bring back all the reflogs though.  But I would 
have expected a repository reduction of the same magnitude even with 
them.


Nicolas
