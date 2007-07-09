From: bdowning@lavos.net (Brian Downing)
Subject: Re: Preferring shallower deltas on repack
Date: Mon, 9 Jul 2007 14:24:03 -0500
Message-ID: <20070709192403.GM4087@lavos.net>
References: <20070709044326.GH4087@lavos.net> <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707090954550.26459@xanadu.home> <7vir8tv8dr.fsf@assigned-by-dhcp.cox.net> <20070709185353.GL4087@lavos.net> <alpine.LFD.0.999.0707091503000.26459@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 21:24:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7yqJ-0008AZ-Lo
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 21:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbXGITYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 15:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbXGITYP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 15:24:15 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:38294 "EHLO
	asav02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbXGITYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 15:24:15 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav02.insightbb.com with ESMTP; 09 Jul 2007 15:24:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnA9ADwnkkZKhvbzR2dsb2JhbACBSoVdiAMBAT8B
Received: by mail.lavos.net (Postfix, from userid 1000)
	id EE92B309F31; Mon,  9 Jul 2007 14:24:03 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707091503000.26459@xanadu.home>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52014>

On Mon, Jul 09, 2007 at 03:13:54PM -0400, Nicolas Pitre wrote:
> Tuning for such an extreme without impacting normal cases is rather 
> hard.
> 
> My patch was meant to be used on top of yours.  Is that what you tested?
> 
> Also I'd suggest you do not use a max depth of 1000.  It is simply 
> insane and might possibly make the existing logic less effective.  Even 
> for runtime pack access you want it to be reasonably short, say 100 
> maximum, or even the current default of 50.  Any improvements you might 
> come with (like automatic depth determined on replay cost) should be 
> compared with that default which is known to work well already.

No, I didn't try it on top of mine; sorry.  I'll try that out.

I realize a depth of 1000 is nuts, I'm just using it to expose any
suboptimal delta selection for the nasty versions.lisp-expr case, since
I know that with a window size of 100 it should be easy to keep it from
growing too deep.

-bcd
