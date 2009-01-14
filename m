From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH next v2] git-notes: add test case for multi-line notes
Date: Wed, 14 Jan 2009 19:01:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141900490.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901141627440.3586@pacific.mpi-cbg.de> <496E129B.3020502@trolltech.com> <20090114165633.GC15758@coredump.intra.peff.net> <496E1D77.6000307@viscovery.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-327019500-1231956078=:3586"
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Tor_Arne_Vestb=F8?= <tavestbo@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:02:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNA42-0006iy-KO
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 19:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbZANSAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 13:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbZANSAf
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 13:00:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:45461 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752987AbZANSAe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 13:00:34 -0500
Received: (qmail invoked by alias); 14 Jan 2009 18:00:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 14 Jan 2009 19:00:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FO+ETLHRFm82hNnMxIr8hV5GpLQxqUJy10vixxR
	H5LwZd3xMY89TK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496E1D77.6000307@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105674>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-327019500-1231956078=:3586
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 14 Jan 2009, Johannes Sixt wrote:

> Jeff King schrieb:
> > On Wed, Jan 14, 2009 at 05:28:11PM +0100, Tor Arne Vestbø wrote:
> > 
> >> +MSG=${MSG//%/}
> >> +printf "$MSG" > "$1"
> >> +printf "$MSG" >& 2
> > 
> > Substitution parameter expansion is a bash-ism, IIRC. How about just
> > 
> >   printf %s "$MSG" ?
> 
> A the point was that $MSG contains \n, which should be turned int LF. IMO,
> the easiest way to achieve this is:
> 
> MSG='b3
> c3c3c3c3
> d3d3d3'
> 
> test_expect_success ' ... ' '
>    ...
>    MSG="$MSG" git notes edit
> '
> 
> and go back to using echo in the part cited above.

Heh, I almost suggested it, but I know that I get quoting wrong all the 
time.

Ciao,
Dscho

--8323328-327019500-1231956078=:3586--
