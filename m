From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 10:14:30 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806121013430.23110@xanadu.home>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
 <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
 <20080611213648.GA13362@glandium.org>
 <alpine.DEB.1.00.0806112242370.1783@racer>
 <20080611230344.GD19474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806111918300.23110@xanadu.home>
 <loom.20080612T042942-698@post.gmane.org>
 <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 16:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6naP-0003Lg-Kg
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 16:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762762AbYFLOOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 10:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762759AbYFLOOh
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 10:14:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26769 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762742AbYFLOOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 10:14:35 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2C005GKSW6OAJ0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jun 2008 10:14:31 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84757>

On Thu, 12 Jun 2008, Wincent Colaiuta wrote:

> Yes, we shouldn't _encourage_ people to use stashes as a long-term storage
> mechanism, but neither should we allow old stashes to silently disappear as a
> result of reflog expiry, especially as part of automatic garbage collection.
> There are two reasons:
> 
> (1) Normal reflogs accumulate cruft automatically through normal use and if
> not cleaned up they'll just grow and grow and grow. On the other hand, for
> "git stash" to accumulate cruft over the long term the user actually has to
> take action and _abuse_ them. Abuse is less likely because it requires this
> conscious action, and as the output of "git stash list" gets bigger and more
> unwieldy this will serve to encourage people to clean out their stashes
> themselves, or not let the list grow out of control in the first place. In
> other words, the size of the stash reflog is unlikely to be a problem.
> 
> (2) Automatically expiring normal reflogs is a service to the user, because
> it's cleaning up something that is automatically generated. Stashes are the
> result of a concious user decision to create them, so automatically "cleaning
> them up" is _not_ going to help the user.
> 
> So yes, branches _are_ better and more appropriate for long term storage than
> stashes, but even so I don't think it's right for us to risk throwing away
> information that the user explicitly stashed and expected Git to look after
> for them.

Fair enough.


Nicolas
