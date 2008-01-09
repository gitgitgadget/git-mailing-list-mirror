From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 14:03:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801091401101.31053@racer.site>
References: <C3AA823B.10C50%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 15:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCbXL-0004FY-LX
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 15:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbYAIODh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 09:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbYAIODg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 09:03:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:45722 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754003AbYAIODf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 09:03:35 -0500
Received: (qmail invoked by alias); 09 Jan 2008 14:03:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 09 Jan 2008 15:03:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mJUIjWB2m4SNbEO9EcqBZD1fOjsp+fzrf1+JTWf
	2nGnkw68AVOMjD
X-X-Sender: gene099@racer.site
In-Reply-To: <C3AA823B.10C50%jefferis@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69993>

Hi,

On Wed, 9 Jan 2008, Gregory Jefferis wrote:

> On 9/1/08 12:41, "Steffen Prohaska" <prohaska@zib.de> wrote:
> 
> > I'll further think about "crlf=safe" (see another mail in this 
> > thread). I like the idea of safe because it guarantees that data will 
> > never be corrupted.  But I have no time to think about it immediately.
> 
> crlf=safe [i.e. munging CRLFs only if there are no bare LFs] sounds 
> appealing to me as well because it looks like munging that is always 
> reversible.

There is a bigger problem here, though: As of now, you can add a (loose) 
object from a big file pretty easily even on a small machine, because you 
do not need the whole buffer, but you stream it to hash-object.  IIRC 
Junio wrote a patch to allow this with "git-add", using fast-import, but 
that patch probably hasn't been applied.

Ciao,
Dscho
