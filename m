From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 00:05:45 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001292352540.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ca433831001291840o751fa02eve1ae301537674325@mail.gmail.com>
 <alpine.LFD.2.00.1001292208470.1681@xanadu.home>
 <ca433831001291959m76ed6adap32a17c10e465af1f@mail.gmail.com>
 <alpine.LFD.2.00.1001292305500.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:06:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb5XN-0000Ax-0B
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 06:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929Ab0A3FFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 00:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906Ab0A3FFr
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 00:05:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55215 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab0A3FFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 00:05:46 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX100DQJNHLXJF0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 30 Jan 2010 00:05:46 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.1001292305500.1681@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138441>

On Fri, 29 Jan 2010, Nicolas Pitre wrote:

> On Fri, 29 Jan 2010, Mark Lodato wrote:
> 
> > This discussion brings up another good point: The main worry about a
> > detached head is losing commits.  Back in 2008, it was suggested to
> > have a warning when committing on a detached HEAD:
> > 
> > http://kerneltrap.org/mailarchive/git/2008/9/2/3169744
> > 
> > This was before the advice system, so folks complained about it
> > getting in the way, and it was never implemented.  Since we now have a
> > way to easily turn off the warning, perhaps we should bring this topic
> > up again (probably as a separate thread.)
> 
> Possibly.  I don't like the message proposed in that patch though.  
> Since the warning when actually detaching HEAD is about to become way 
> more prominent, the per-commit warning doesn't have to be that noisy 
> anymore.

Thinking more about it, I still consider that making 'git commit' more 
noisy is the wrong approach.  Again, the problem is not about making 
commits on a detached HEAD.  but rather about losing those commits at 
the next 'git checkout'.  Probably a warning should be made when that 
checkout is attempted after one or more commits were made on a detached 
HEAD instead, and refuse the checkout by default unless it is forced (-f 
is already taken for some other force meaning).  The warning should say 
how not to lose those commits by suggesting a branch creation, or give 
the hint for performing the checkout anyway.


Nicolas
