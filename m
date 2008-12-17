From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Wed, 17 Dec 2008 11:46:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812171136250.30035@xanadu.home>
References: <4946F4D9.8050803@gmx.ch> <87zlixvtu9.fsf@jidanni.org>
 <49470D65.40808@gmx.ch> <alpine.LFD.2.00.0812160039180.30035@xanadu.home>
 <20081217154407.GZ32487@spearce.org>
 <alpine.LFD.2.00.0812171104340.30035@xanadu.home>
 <20081217162127.GG32487@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jean-Luc Herren <jlh@gmx.ch>, jidanni@jidanni.org,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 17:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCzZo-0006AL-DZ
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 17:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbYLQQrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 11:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYLQQrJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 11:47:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57908 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbYLQQrI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 11:47:08 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KC100DRR59U3MK0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Dec 2008 11:46:44 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081217162127.GG32487@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103360>

On Wed, 17 Dec 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > 
> > And I consider any system doing such thing completely stupid.  Either 
> > you consistently know the information or you don't.  When you don't, it 
> > is best to not create expectations for the user.  And so far I think 
> > that 99.9% of git users are just fine with the progress display we 
> > currently provide.
> 
> Certainly true here; I never care how big the source I'm cloning is.
> But then again I have pretty good network connectivity at work
> and at least cable modem service at home...  most things clone down
> pretty fast.
> 
> Its a quick hack to give a size upper bound.  I don't think its
> that ugly.  Our network protocol is uglier with all of its hidden
> fields jammed behind that NUL in the first advertisement line.
> But I digress.

The ugliness in the protocol is encapsulated away from user view, and we 
could even seemlessly introduce a new protocol at any time with no 
issues if we wanted to.

This "quick hack" is imprecise, unreliable, and directly affect user 
perception.  This is way more dammageable as once users are used to it, 
good or bad, it won't be possible to get rid of it.

> The better feature is probably resumable clone anyway.  At least
> then people can abort a "long running" clone and have a good chance
> they can pick it up again in the near future.

Absolutely.

> Its also not easy to
> implement, which is why we've only been talking about it for years
> and never actually seen a patch proposing to do it.

A partial clone could possibly be turned into a shalow clone if at least 
the top commit is complete ...


Nicolas
