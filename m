From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 23:38:57 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711302338350.27959@racer.site>
References: <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org>
 <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de> <20071130151223.GB22095@coredump.intra.peff.net>
 <8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com>
 <20071130152942.GA22489@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0711300745330.8458@woody.linux-foundation.org>
 <20071130162257.GA22882@coredump.intra.peff.net> <Pine.LNX.4.64.0711301828050.27959@racer.site>
 <20071130183755.GA29382@sigill.intra.peff.net> <Pine.LNX.4.64.0711302305300.27959@racer.site>
 <20071130232127.GA3169@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi B?jar <sbejar@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 00:39:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyFSb-0002X3-4h
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 00:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974AbXK3XjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 18:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761428AbXK3XjQ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 18:39:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:37095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757830AbXK3XjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 18:39:15 -0500
Received: (qmail invoked by alias); 30 Nov 2007 23:39:13 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp011) with SMTP; 01 Dec 2007 00:39:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9JlIlNOb9erzypOVWnS/TE3c3SR2p3juZIHW9T/
	+vef7gKt9QxNZV
X-X-Sender: gene099@racer.site
In-Reply-To: <20071130232127.GA3169@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66668>

Hi,

On Fri, 30 Nov 2007, Jeff King wrote:

> On Fri, Nov 30, 2007 at 11:05:50PM +0000, Johannes Schindelin wrote:
> 
> > > > >  	alias_command = (*argv)[0];
> > > > >  	git_config(git_alias_config);
> > > > > +	if (!alias_string)
> > > > > +		alias_string = builtin_alias(alias_command);
> > > > >  	if (alias_string) {
> > > > >  		if (alias_string[0] == '!') {
> > > > >  			if (*argcp > 1) {
> > > > 
> > > > Didn't you mean to put this _before_ the git_config() call?  As you wrote 
> > > > it, the "soft" alias overrides the user-specified one.
> > > 
> > > No. The "if (!alias_string)" means we only do the lookup if no user
> > > alias was found. Try it.
> > 
> > Ah.  To me, that was rather easy to miss, though...
> 
> I don't particularly care if it is re-written as:
> 
>   alias_string = builtin_alias(alias_command);
>   git_config(git_alias_config);
> 
> which should be equivalent.  I wrote it the original way to avoid doing
> the O(n) search through builtin aliases when it was unnecessary, but
> obviously this isn't a performance critical code path.

Actually, I felt/feel quite dumb missing it.

Ciao,
Dscho
