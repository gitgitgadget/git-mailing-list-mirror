From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH, take 2] Linear-time/space rename logic (exact renames
	only)
Date: Mon, 22 Oct 2007 23:17:06 +0200
Message-ID: <20071022211706.GD23714@steel.home>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org> <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org> <alpine.LFD.0.999.0710220932150.10525@woody.linux-foundation.org> <alpine.LFD.0.999.0710221009580.10525@woody.linux-foundation.org> <alpine.LFD.0.999.0710221207300.30120@woody.linux-foundation.org> <alpine.LFD.0.999.0710221241560.30120@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
	Sven Verdoolaege <skimo@liacs.nl>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 23:17:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik4ea-00045O-L7
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 23:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbXJVVRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 17:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbXJVVRS
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 17:17:18 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:32377 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbXJVVRR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 17:17:17 -0400
Received: from tigra.home (Fab70.f.strato-dslnet.de [195.4.171.112])
	by post.webmailer.de (fruni mo16) (RZmta 13.6)
	with ESMTP id L03957j9MJVoGH ; Mon, 22 Oct 2007 23:17:10 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C4EBE277AE;
	Mon, 22 Oct 2007 23:17:06 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1CDFF56D22; Mon, 22 Oct 2007 23:17:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710221241560.30120@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKf+sU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62047>

Linus Torvalds, Mon, Oct 22, 2007 21:44:48 +0200:
> 
> 
> On Mon, 22 Oct 2007, Linus Torvalds wrote:
> > 
> > I'm sure there's more to come..
> 
> One more detail.. The updated comment explains the issue: if we broke a 
> file apart, and rename detection joined it back together, the result is 
> neither a rename nor a copy, it's a regular modification (and all 
> remaining renames will be copies of the original, so don't bother 
> decrementing the "rename_used" count).

It breaks t3402-rebase-merge.sh
