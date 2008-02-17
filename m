From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] sending errors to stdout under $PAGER
Date: Sun, 17 Feb 2008 19:38:23 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802171937070.30505@racer.site>
References: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org> <20080217144854.56fcb98d.froese@gmx.de> <7vd4qv1n78.fsf@gitster.siamese.dyndns.org> <20080217181523.GA4818@coredump.intra.peff.net> <7vr6fbzbky.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Edgar Toernig <froese@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:39:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQpMH-0007Ht-E3
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbYBQTif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYBQTif
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:38:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:40193 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753133AbYBQTie (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:38:34 -0500
Received: (qmail invoked by alias); 17 Feb 2008 19:38:32 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp051) with SMTP; 17 Feb 2008 20:38:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NxLNedyCN2CczKOWoueiXt4n+hniXPwclVhajsd
	h4D4V1UiAVW1lN
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6fbzbky.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74173>

Hi,

On Sun, 17 Feb 2008, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sun, Feb 17, 2008 at 09:56:27AM -0800, Junio C Hamano wrote:
> >
> >> > Wouldn't it be better/safer to redirect stderr to the pager in the 
> >> > first place?
> >> >
> >> > So, instead of the current
> >> >
> >> > 	foo | less
> >> > use
> >> > 	foo 2>&1 | less
> >> 
> >> I like it.  Much nicer.  Thanks.
> >
> > This will also put the stderr of any sub-programs into the pager, 
> > which is probably worse if you have, e.g., a chatty external diff 
> > program. I don't know if we care enough about that.
> 
> We'll soon find out and the change would be a single liner that is very 
> easy to back out, so let's put it in and see what happens ;-).

I think this is a non-problem.  External diff programs are virtually all 
scripts written for git, because of the calling convention.  So all this 
does is tell the people who use external diff wrappers (and let them be 
chatty) to fix their scripts.

Ciao,
Dscho
