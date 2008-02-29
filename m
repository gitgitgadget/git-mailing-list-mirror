From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/40] Windows: Use the Windows style PATH separator
 ';'.
Date: Fri, 29 Feb 2008 12:19:48 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802291214160.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-5-git-send-email-johannes.sixt@telecom.at> <47C67E1A.5030304@gnu.org> <200802282143.19322.johannes.sixt@telecom.at> <47C7BAEE.2020408@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 13:21:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV4Eu-0004oH-6a
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 13:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756953AbYB2MU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 07:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757593AbYB2MU0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 07:20:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:39395 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754831AbYB2MUY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 07:20:24 -0500
Received: (qmail invoked by alias); 29 Feb 2008 12:20:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 29 Feb 2008 13:20:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VQ49UUgPVG+GTV7k/Vn3ztpcW7b+FpSnqi+jtGj
	GPq+iB9d5U4qK/
X-X-Sender: gene099@racer.site
In-Reply-To: <47C7BAEE.2020408@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75527>

Hi,

On Fri, 29 Feb 2008, Paolo Bonzini wrote:

> Johannes Sixt wrote:
> > On Thursday 28 February 2008 10:25, Paolo Bonzini wrote:
> > > > +#ifdef __MINGW32__
> > > > +		strbuf_addch(out, ';');
> > > > +#else
> > > >  		strbuf_addch(out, ':');
> > > > +#endif
> > > Why not adding a PATH_SEPARATOR #define?
> > 
> > Because IMO it is obfuscating:
> > 
> > 1. When you read through the code and see PATH_SEPARATOR, you still have
> > to go look how it's defined. Why? Because you always will ask: Is this about
> > ':' vs. ';' or '/' vs. '\\'?
> 
> One is a DIR_SEPARATOR, the other is a PATH_SEPARATOR.  It's a matter of
> conventions.

I agree that it would be good, also for documentation purposes, to add the 
#defines.

However, there is something ugly waiting for us: we often have

	case '/':

and for Windows, this needs to add

	case '\\':

Now, we could #define CASE_DIR_SEPARATOR, which expands to "case '/': case 
'\\':" on Windows, but I am prepared to let Windows uglify our source code 
only so far *does the famous imitation of Linus where he puts two finger 
so close that you cannot see between them*.

Ciao,
Dscho

