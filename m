From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL
 characters
Date: Sat, 17 May 2008 11:18:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805171117010.30431@racer>
References: <482BE5F7.2050108@thorn.ws> <alpine.DEB.1.00.0805161139530.30431@racer> <alpine.DEB.1.00.0805161148010.30431@racer> <alpine.DEB.1.00.0805161403130.30431@racer> <32541b130805160703r27a55b91xbad03eb1d107a176@mail.gmail.com> <alpine.DEB.1.00.0805161529390.30431@racer>
 <32541b130805160756h5a8fc4d7x313f9bfde4760568@mail.gmail.com> <alpine.DEB.1.00.0805170058160.30431@racer> <20080517100726.GA24416@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sat May 17 12:19:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxJVG-0001l1-H6
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 12:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbYEQKSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 06:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbYEQKSM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 06:18:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:51059 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751574AbYEQKSM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 06:18:12 -0400
Received: (qmail invoked by alias); 17 May 2008 10:18:10 -0000
Received: from R06ea.r.pppool.de (EHLO racer.local) [89.54.6.234]
  by mail.gmx.net (mp038) with SMTP; 17 May 2008 12:18:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HuCFpqS9HWEAxr8J2zubE/6aKg7zREhrZTcE4d8
	YqrNwolxRsRLgB
X-X-Sender: gene099@racer
In-Reply-To: <20080517100726.GA24416@cuci.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82342>

Hi,

On Sat, 17 May 2008, Stephen R. van den Berg wrote:

> Johannes Schindelin wrote:
> >On Fri, 16 May 2008, Avery Pennarun wrote:
> >> fread is about 18x faster than fgetc().  getc() is the same speed as
> >> fgetc().  getc_unlocked() is definitely faster than getc, but still at
> >> least 7x slower than fread().
> 
> >Well, my question was more about fgetc() vs fgets().
> >If you feel like it, you might benchmark this patch:
> 
> Wouldn't it be better to improve the implementation of getc()
> in glibc instead?

Sure, because glibc is used on Windows, AIX, Solaris, etc.

> getc() is meant to be the fast version of fgetc(), and if it isn't 
> (anymore), then the library needs fixing.

fgetc() has to work reliably in a threaded environment, too.  So I guess 
that it does all kinds of locks that slow it down, but it is not something 
to be "fixed".

Hth,
Dscho
