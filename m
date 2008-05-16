From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL
 characters
Date: Fri, 16 May 2008 15:32:20 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161529390.30431@racer>
References: <482BE5F7.2050108@thorn.ws>  <alpine.DEB.1.00.0805161139530.30431@racer>  <alpine.DEB.1.00.0805161148010.30431@racer>  <alpine.DEB.1.00.0805161403130.30431@racer> <32541b130805160703r27a55b91xbad03eb1d107a176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 16:34:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0zc-0005Xd-I1
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbYEPOcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYEPOcQ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:32:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:43598 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752599AbYEPOcP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:32:15 -0400
Received: (qmail invoked by alias); 16 May 2008 14:32:14 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp037) with SMTP; 16 May 2008 16:32:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/fzErJXo/05oiJ0t2b6aH7eyi1BjIocMSufOlGV
	CH6qH2bCN7WUBO
X-X-Sender: gene099@racer
In-Reply-To: <32541b130805160703r27a55b91xbad03eb1d107a176@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82297>

Hi,

On Fri, 16 May 2008, Avery Pennarun wrote:

> On 5/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >         BTW I do not know how much fgetc() instead of fgets() slows
> >         down things, but I expect both to be equally fast because
> >         they are both buffered, right?
> 
> In my experience, fgetc() is pretty fantastically slow because you
> have a function call for every byte (and, I gather, modern libc does
> thread locking for every fgetc).  It's usually much faster to fread()
> into a buffer and then access the buffer.

Hmpf.  I hoped to get more definitive information here.  Especially given 
that fgetc() is nothing more than a glorified fread() into a buffer, and 
then access the buffer.

Well, at least you kind of pointed me to the _unlocked() function family.

Ciao,
Dscho
