From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] checkout to notice forks (Re: Minor annoyance with git
 push)
Date: Sun, 17 Feb 2008 12:36:43 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802171146220.5496@iabervon.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <7vtzkihkx5.fsf@gitster.siamese.dyndns.org> <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com> <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
 <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802162202310.5496@iabervon.org> <7v4pc843yg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802170114440.5496@iabervon.org> <7vy79k2fus.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 18:37:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQnS7-0004uX-3s
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 18:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbYBQRgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 12:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbYBQRgp
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 12:36:45 -0500
Received: from iabervon.org ([66.92.72.58]:52071 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbYBQRgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 12:36:44 -0500
Received: (qmail 452 invoked by uid 1000); 17 Feb 2008 17:36:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 17:36:43 -0000
In-Reply-To: <7vy79k2fus.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74140>

On Sat, 16 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I'm also in part worried about the lack of publicity "struct branch" has 
> > gotten; it would have saved you having to write 64 of 136 lines, so it's 
> > worth you knowing about.
> 
> Actually, I initially took a look at branch.h and tried to reuse
> find_tracked_branch() but then realized it was a wrong interface.

Yeah, that's the other direction, and for setting it up (so the 
configuration isn't there yet, and it's trying to figure out what the 
requested default is).

> The "struct branch" in remote.h (Heh) looks like the right
> interface.

Now that branch.h exists, it probably should have struct branch, I guess. 
Back when I made struct branch, it was just about finding the right 
configuration for fetch, so I was thinking more about the "doing the right 
thing with remotes" aspect than the "configuration about branches" aspect. 
They're somewhat intertwined, in any case, because remote_get(NULL) uses 
the branch configuration to find the default, and branch_get() uses the 
remote configuration to interpret merge settings.

> Documentation/technical/api-*.txt should really talk about
> what's in remote.c.

Ah, that's where that should go. I remember reading about it while I was 
on vacation and promptly forgetting all about it. Writing stuff up now.

	-Daniel
*This .sig left intentionally blank*
