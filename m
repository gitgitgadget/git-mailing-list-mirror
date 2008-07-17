From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Thu, 17 Jul 2008 12:25:36 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807171215020.3110@xanadu.home>
References: <20080713011512.GB31050@spearce.org>
 <1216001267-33235-1-git-send-email-spearce@spearce.org>
 <alpine.LFD.1.10.0807132220570.12484@xanadu.home>
 <20080714031242.GA14542@spearce.org>
 <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de>
 <m31w1wu1hc.fsf@localhost.localdomain> <487B439F.8040902@op5.se>
 <alpine.DEB.1.00.0807141322140.8950@racer> <487B4BD8.5030208@op5.se>
 <alpine.LFD.1.10.0807142203530.12484@xanadu.home>
 <20080715024741.GB1700@spearce.org> <487F6E04.9050106@arcor.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Hennig <mailing_list@arcor.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 18:27:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWK9-0002xp-4W
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 18:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225AbYGQQ0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 12:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756214AbYGQQ0W
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 12:26:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51129 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052AbYGQQ0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 12:26:21 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4500J9QSAOEP40@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Jul 2008 12:25:36 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <487F6E04.9050106@arcor.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88875>

On Thu, 17 Jul 2008, Stephan Hennig wrote:

> Shawn O. Pearce schrieb:
> 
> > We're better off keeping our memory usage low and recomputing
> > the delta base when we need to return to it to process a sibling.
> 
> Thanks to all who have had a look at this issue!  From a user's
> perspective I have one more suggestions and a question:
> 
> First, it would have helped me to bring this issue onto the list if I
> had earlier known that this was no misconfiguration, but a memory
> problem.

Well, if we had known before that this could be a problem, we'd have 
fixed it earlier.  In other words, sh*t happens.

> Even though Git now makes some efforts to substitute runtime
> for memory to be able to operate with low(er) memory, I think it would
> still be informative for a user that repository and hardware, resp.
> core.deltaBaseCacheLimit, are, say, incompatible.  If valuable objects
> have to be discarded due to memory restrictions a warning could be
> issued to make the user aware of this fact, e.g.,
> 
>   Warning! Low memory. Git might be slowing down.

Well, I disagree.  First we don't know how slow git would effectively be 
since all (my) concerns so far were totally theoretical.  It will still 
work better than, say, 'git verify-pack' nevertheless. And git should 
just do its best regardless and avoid being needlessly verbose.

> Second, while there have been some changes to Git now, as a poor user,
> how can I make use of that changes?  I think, updating my client should
> only help with pushing.  For pulling, I have to wait for repo.or.cz to
> update to Git 1.6.0, right?

Actually that's the other way around.  This change will help the 
receiving side of a transfer.  So it should help you when pulling.


Nicolas
