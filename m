From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 100%
Date: Sat, 23 Jun 2007 21:41:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706232130230.4059@racer.site>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net>
 <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com>
 <Pine.LNX.4.64.0706221122200.4059@racer.site> <86ps3oi7ma.fsf_-_@lola.quinscape.zz>
 <Pine.LNX.4.64.0706221347480.4059@racer.site> <86abusi1fw.fsf@lola.quinscape.zz>
 <Pine.LNX.4.64.0706230222330.4059@racer.site> <467CF380.6060603@lsrfire.ath.cx>
 <Pine.LNX.4.64.0706231154300.4059@racer.site> <7vk5tu4gas.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 22:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2CQC-000426-5h
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 22:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbXFWUl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 16:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXFWUl0
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 16:41:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:40038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751191AbXFWUl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 16:41:26 -0400
Received: (qmail invoked by alias); 23 Jun 2007 20:41:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 23 Jun 2007 22:41:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oHTxd47Jo1QSH3wkn3rABfXA4fBgyYGkmKKXysY
	Mv9w+NP9qt1plq
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5tu4gas.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50751>

Hi,

On Sat, 23 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > By the same reasoning, you could say "never round down to 0%, because I 
> > want to know when there is no similarity".
> >
> > You cannot be exact when you have to cut off fractions, so why try for 
> > _exactly_ one number?
> 
> R0 or C0 would not happen in real life, so 0% is a moot issue.

It is, but not when you look at the formula.

> However, wasn't that you who did follow that "certain numbers
> are special" logic in diffstat?
> 
> You advocated "diff --stat" should draw at least one +/- for a
> patch that adds/removes lines.  And I (and others) agreed
> because zero is special in the context of that application.

Actually, it was not me, but I implemented the version that we have now. 
I was reasonably scared that a non-linear diffstat would end up in git, 
therefore I wrote a linear one.

The important thing to not here is that the diffstat as-is makes _better_ 
use of the limited scale that is available.

And as you pointed out, the low end of the scale is not really 
interesting. The interesting parts are those around 100%. By rounding down 
you make less use of the available scale.

> I think reserving R100 to mean "identical byte sequences" has value, 
> when people look at --name-status output, in the context of "similarity 
> index".

Ah, whatever. You do what you want.

Yes, this interpretation has value. No, it is not the only one that has 
value. I am much more used to rounding, since at the end of the day it 
makes better use of the scale, it is commonly used, and therefore _I_ 
expect it (and no, I will not read the documentation when I expect to know 
what it means).

But hey, I don't care any more. AFAIAC you can change it from rounding to 
rounding down, and next year to rounding-up. We could even have an 
algorithm which rounds down only in odd years, and I still would not care.

Ciao,
Dscho
