From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 01:38:58 -0400
Message-ID: <20070719053858.GE32566@spearce.org>
References: <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Kastrup <dak@gnu.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 07:39:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBOjI-0006e8-Jr
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 07:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbXGSFjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 01:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbXGSFjI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 01:39:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38894 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbXGSFjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 01:39:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IBOj7-0004mr-0E; Thu, 19 Jul 2007 01:39:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C218620FBAE; Thu, 19 Jul 2007 01:38:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52936>

Junio C Hamano <gitster@pobox.com> wrote:
> Another issue I thought about was what you would do in the step
> 3 in the following:
> 
>  1. David says "mkdir D; git add D"; you add S_IFDIR entry in
>     the index at D;
> 
>  2. David says "date >D/F; git add D/F"; presumably you drop D
>     from the index (to keep the index more backward compatible)
>     and add S_IFREG entry at D/F.
> 
>  3. David says "git rm D/F".
> 
> Have we stopped keeping track of the "empty directory" at this
> point?

Sadly yes.  But I don't think that's what the folks who want to
track empty directories want to have happen here.

Which is why I'm thinking we just need to track the directory, as a
node in the index, even if there are files in it, and even if we got
that directory and its contained files there by just unpacking trees.

-- 
Shawn.
