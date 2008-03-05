From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Wed, 5 Mar 2008 23:18:53 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803052317350.15786@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200803052221.12495.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:20:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX1yZ-00018G-Du
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 23:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763193AbYCEWS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 17:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763188AbYCEWSy
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 17:18:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:38660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764735AbYCEWSx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 17:18:53 -0500
Received: (qmail invoked by alias); 05 Mar 2008 22:18:51 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp028) with SMTP; 05 Mar 2008 23:18:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZJQEt5jzZ1esPH9EDoK00a6OZQx3BFZds8gdfKT
	YCzwNKu2qHA4Re
X-X-Sender: gene099@racer.site
In-Reply-To: <200803052221.12495.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76276>

Hi,

On Wed, 5 Mar 2008, Johannes Sixt wrote:

> On Thursday 28 February 2008 13:05, Johannes Schindelin wrote:
> > On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > > --- a/git-compat-util.h
> > > +++ b/git-compat-util.h
> > > @@ -357,6 +359,10 @@ static inline FILE *xfdopen(int fd, const char
> > > *mode) return stream;
> > >  }
> > >
> > > +#ifdef __MINGW32__
> > > +int mkstemp(char *template);
> > > +#endif
> > > +
> > >  static inline int xmkstemp(char *template)
> > >  {
> > >  	int fd;
> >
> > Could we have this...
> >
> > > @@ -437,4 +443,140 @@ void git_qsort(void *base, size_t nmemb, size_t
> > > size, #define qsort git_qsort
> > >  #endif
> > >
> > > +#ifdef __MINGW32__
> > > +
> > > +#include <winsock2.h>
> > > +
> > > +/*
> > > + * things that are not available in header files
> > > + */
> > > +
> > > [...]
> >
> > ... and this in compat/mingw.h?  And then, we'd only have
> >
> > #ifdef __MINGW32__
> > #include "mingw.h"
> > #endif
> >
> > in git-compat-util.h?
> 
> I've now created compat/mingw.h. Below is the interdiff. Of course, it 
> mostly only moves code around. But you might want to look at at mkstemp, 
> PATH_SEP, PRIuMAX, and has_dos_drive_prefix. Notice also that I include 
> compat/mingw.h early in git-compat-util.h instead of late.

Thanks!

With this, I think I have nothing to add to your series (except maybe an 
Acked-by: where it applies, or a Reviewed-by:, but I think that this 
would only be a burden on our maintainer).

Ciao,
Dscho

