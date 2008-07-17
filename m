From: Stephan Hennig <mailing_list@arcor.de>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Thu, 17 Jul 2008 18:06:28 +0200
Message-ID: <487F6E04.9050106@arcor.de>
References: <20080713011512.GB31050@spearce.org> <1216001267-33235-1-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0807132220570.12484@xanadu.home> <20080714031242.GA14542@spearce.org> <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de> <m31w1wu1hc.fsf@localhost.localdomain> <487B439F.8040902@op5.se> <alpine.DEB.1.00.0807141322140.8950@racer> <487B4BD8.5030208@op5.se> <alpine.LFD.1.10.0807142203530.12484@xanadu.home> <20080715024741.GB1700@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 18:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJW2e-0003r3-VL
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 18:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbYGQQIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 12:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756569AbYGQQIR
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 12:08:17 -0400
Received: from main.gmane.org ([80.91.229.2]:59748 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861AbYGQQIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 12:08:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJW1e-0007Fq-1V
	for git@vger.kernel.org; Thu, 17 Jul 2008 16:08:14 +0000
Received: from dialin-145-254-066-169.pools.arcor-ip.net ([145.254.66.169])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 16:08:14 +0000
Received: from mailing_list by dialin-145-254-066-169.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 16:08:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dialin-145-254-066-169.pools.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12
In-Reply-To: <20080715024741.GB1700@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88871>

Shawn O. Pearce schrieb:

> We're better off keeping our memory usage low and recomputing
> the delta base when we need to return to it to process a sibling.

Thanks to all who have had a look at this issue!  From a user's
perspective I have one more suggestions and a question:

First, it would have helped me to bring this issue onto the list if I
had earlier known that this was no misconfiguration, but a memory
problem.  Even though Git now makes some efforts to substitute runtime
for memory to be able to operate with low(er) memory, I think it would
still be informative for a user that repository and hardware, resp.
core.deltaBaseCacheLimit, are, say, incompatible.  If valuable objects
have to be discarded due to memory restrictions a warning could be
issued to make the user aware of this fact, e.g.,

  Warning! Low memory. Git might be slowing down.


Second, while there have been some changes to Git now, as a poor user,
how can I make use of that changes?  I think, updating my client should
only help with pushing.  For pulling, I have to wait for repo.or.cz to
update to Git 1.6.0, right?

Best regards,
Stephan Hennig
