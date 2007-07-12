From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] apply delta depth bias to already deltified objects
Date: Thu, 12 Jul 2007 14:07:27 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707121404090.32552@xanadu.home>
References: <alpine.LFD.0.999.0707120049120.32552@xanadu.home>
 <20070712152016.GB19073@lavos.net>
 <alpine.LFD.0.999.0707121146550.32552@xanadu.home>
 <20070712164458.GC19073@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:07:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I934s-0000HS-7Y
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbXGLSHn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754796AbXGLSHn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:07:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36687 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbXGLSHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 14:07:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL200H0EVOFXU60@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 14:07:28 -0400 (EDT)
In-reply-to: <20070712164458.GC19073@lavos.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52310>

On Thu, 12 Jul 2007, Brian Downing wrote:

> On Thu, Jul 12, 2007 at 12:27:02PM -0400, Nicolas Pitre wrote:
> > Better yet, the integer truncation error should be compensated for, with 
> > this:
> > 
> >     max_size =
> >         (trg_entry->delta_size * max_depth + max_depth - trg_entry->depth) /
> >                     (max_depth - trg_entry->depth + 1);
> 
> Yep, with this, my degenerate case seems to find the optimum solution
> (depth ~ 65) even at crazy maximum depths like 1000.
> 
> Looks good to me.

Great.

Now to conclude this, I have a patch with much simpler math which I'll 
post rsn.


Nicolas
