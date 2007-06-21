From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Thu, 21 Jun 2007 15:03:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211459140.4059@racer.site>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 16:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1NGd-0005EI-6F
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 16:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbXFUOEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 10:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbXFUOEH
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 10:04:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:53916 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752287AbXFUOEG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 10:04:06 -0400
Received: (qmail invoked by alias); 21 Jun 2007 14:03:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 21 Jun 2007 16:03:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18v3QQrEocvCdJ7zcsPFVx0cX8+7qqnHkCU8hsMu/
	hKAThwdsNPfXIi
X-X-Sender: gene099@racer.site
In-Reply-To: <20070621131915.GD4487@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50628>

Hi,

On Thu, 21 Jun 2007, Jeff King wrote:

> On Thu, Jun 21, 2007 at 12:52:11PM +0100, Johannes Schindelin wrote:
> 
> > When there are several candidates for a rename source, and one of them
> > has an identical basename to the rename target, take that one.
> 
> That's a reasonable heuristic, but it unfortunately won't match simple
> things like:
> 
>   i386_widget.c -> arch/i386/widget.c

That's right. But every heuristic falls down eventually. Personally, I 
think basename_same() is good enough, even if the technical challenge to 
implement a small enough Levenshtein, which still respects directory 
boundaries somehow (and not just throws them away).

Besides, Levenshtein would introduce a ranking, not a boolean value like 
basename_same(). And that complicates the code.

All in all, I'd say Levenshtein is not worth the _result_.

Ciao,
Dscho
