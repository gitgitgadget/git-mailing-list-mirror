From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Fri, 29 Feb 2008 01:07:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290105150.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200802282140.30654.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 29 02:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUtke-0008Ke-Fv
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930AbYB2BIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760046AbYB2BIP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:08:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:54233 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759890AbYB2BIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:08:13 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:08:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp017) with SMTP; 29 Feb 2008 02:08:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UTiMIC4zUOlWwgniLGqF+DA96H94xW60BXyo9lm
	ww7jodlZDHkQa0
X-X-Sender: gene099@racer.site
In-Reply-To: <200802282140.30654.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75479>

Hi,

On Thu, 28 Feb 2008, Johannes Sixt wrote:

> On Thursday 28 February 2008 13:05, Johannes Schindelin wrote:
> >
> > On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > 
> > > +#ifdef __MINGW32__
> > > +int mkstemp(char *template);
> > > +#endif
> > > +
> > >  static inline int xmkstemp(char *template)
> > >  {
> > >  	int fd;
> >
> > Could we have this...
> 
> No, becauser xmkstemp needs the forward declaration of mkstemp(). But we 
> could make it unconditional.

Actually, I was thinking of including it at the same spot where you 
declare mkstemp conditionally.  (Of course, since I spotted very well that 
you need that declaration for xmkstemp().)

> I thought about this, but I decided against it:  git-compat-util.h is 
> the place to look for compatibility functions. A file compat/mingw.h 
> only introduces an extra indirection and only *hides* stuff instead of 
> making it obvious.

Well, the thing is, there are quite a few definitions and declarations 
that are _only_ _ever_ interesting if you are on MinGW32.

So maybe it is a good idea to hide it to all the other users.

Ciao,
Dscho

