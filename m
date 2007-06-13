From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Wed, 13 Jun 2007 23:20:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706132317240.4059@racer.site>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site>
 <20070613184109.GG10941@coredump.intra.peff.net> <Pine.LNX.4.64.0706131953370.4059@racer.site>
 <20070613200011.GA17360@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:24:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HybGf-0004qg-BV
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 00:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbXFMWYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755035AbXFMWYK
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 18:24:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:35957 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754073AbXFMWYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 18:24:09 -0400
Received: (qmail invoked by alias); 13 Jun 2007 22:24:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 14 Jun 2007 00:24:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18f8DdaMzsf/P/UkhhB8FD9daQmQI7USgzsyL7FlM
	5I8AhBHbwFr1mv
X-X-Sender: gene099@racer.site
In-Reply-To: <20070613200011.GA17360@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50137>

Hi,

On Wed, 13 Jun 2007, Jeff King wrote:

> On Wed, Jun 13, 2007 at 07:54:59PM +0100, Johannes Schindelin wrote:
> 
> > :-) Since you seem comfortable with regular expressions, maybe you can 
> > help me: I am looking for a pattern which matches _any_ character, and one 
> > which matches only non-newlines, both with and without REG_NEWLINE. Hmm?
> 
> Without REG_NEWLINE, any character is just '.', but I think you are
> stuck with '[^
> ]' for non-newlines, since POSIX makes no provisions for quoting the
> newline (I just skimmed through POSIX chapter 9, and I didn't see
> anything useful).
> 
> With REG_NEWLINE, non-newlines is of course '.'. Matching both is tricky
> without using extended regular expressions (where you could just do '.|
> '). In fact, I have been playing with it for a few minutes and I can't
> seem to find a good way, since you really want to represent '.' _inside_
> a bracketed alternation sequence. But I don't think there's a character
> class for "everything".
> 
> I think this would be much easier with pcre, but ISTR some opposition to
> that a few months back.

Actually, that's funny. Yesterday, I repeated my claim that pcre is 
slow on IRC, and Sam Villain on IRC accused me of trolling. But as you can 
see from my postings on this list ($gmane/41682), you can see that _I_ had 
numbers to back up my claim.

So no, I think pcre is just not worth it.

> So that's probably not very helpful to you, but at least you have
> confirmation from one other person that the answer isn't totally
> obvious. :)

That confirmation is at least some consolation to me :-)

Ciao,
Dscho "who is not here to teach, but to learn"
