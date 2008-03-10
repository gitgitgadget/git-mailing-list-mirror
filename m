From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-clone: fix for new unpack_trees() semantics
Date: Mon, 10 Mar 2008 11:58:50 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803101157300.3975@racer.site>
References: <alpine.LNX.1.00.0803081803360.19665@iabervon.org> <alpine.LSU.1.00.0803092227230.3975@racer.site> <alpine.LNX.1.00.0803091829100.19665@iabervon.org> <alpine.LSU.1.00.0803092354310.3975@racer.site> <alpine.LNX.1.00.0803091857540.19665@iabervon.org>
 <alpine.LSU.1.00.0803100005060.3975@racer.site> <alpine.LNX.1.00.0803091911010.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 11:59:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYfj5-00006h-5A
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 11:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbYCJK6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 06:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbYCJK6t
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 06:58:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:35061 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750940AbYCJK6s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 06:58:48 -0400
Received: (qmail invoked by alias); 10 Mar 2008 10:58:46 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp026) with SMTP; 10 Mar 2008 11:58:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190SURt/Xt04Wzlv4DkwvCxGWxt8rOQN41xYb9osC
	un0fxEIEx4Y7Lb
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803091911010.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76715>

Hi,

On Sun, 9 Mar 2008, Daniel Barkalow wrote:

> On Mon, 10 Mar 2008, Johannes Schindelin wrote:
> 
> > Yes.  And this sets dst_index (what I tried to hint at with my patch).
> 
> Oh, yes. Your patch is what prompted me to fix that part (and to find 
> that Linus's unpack_trees was in next now). But seeing src_index in your 
> patch made me wonder what it wanted a source index for anyway, since 
> this is the first index we've had in this repo.

Well, stupid copy-'n-paste.  Well, not all that stupid: because of the 
twoway_merge (and because the segmentation fault was in a line accessing 
src_index), I assumed that the src_index is needed.

But your explanation that oneway_merge is all we want makes tons of sense.

Ciao,
Dscho
