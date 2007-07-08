From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Sun, 8 Jul 2007 12:58:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081254450.4248@racer.site>
References: <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
 <200707071011.l67AB9rg005792@mi0.bluebottle.com> <7vabu88qem.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707071317060.4093@racer.site> <7v1wfj4auu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 14:05:55 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7VWS-00087a-PW
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 14:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbXGHMFt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 08:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbXGHMFt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 08:05:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:49798 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751852AbXGHMFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 08:05:48 -0400
Received: (qmail invoked by alias); 08 Jul 2007 12:05:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 08 Jul 2007 14:05:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gWuVd9j2geoT2i+wdP48YE4E9QtYKcLk3ADnuwU
	1umho5QTFSG/7q
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wfj4auu.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51876>

Hi,

On Sun, 8 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > +	if (!strcmp(ident, "tex"))
> >> > +		return "^\\\\\\(sub\\)*section{";
> >
> > It is always easier, and will never require C skills, to put this into the 
> > config. With Junio's current version:
> >
> > 	echo '*.tex funcname=tex' >> .gitattributes
> > 	echo '[funcname] tex = ^\(\\\(sub\)*section{.*\)' >> .git/config
> >
> > The problem is of course that the backslashes have to be escaped _both_ in 
> > C and in regexps.
> 
> I think giving a reasonable set of basic language support as
> built-in patterns is important for usability.  Otherwise the
> users end up needing to have them in their $HOME/.gitconfig.

I agree.

> I am not sure if Java and LaTeX qualify as the first two most important 
> cases, but they are what we already have demonstrated.

Java and LaTeX are the two languages I use, for which the inbuilt funcname 
default is absolutely unusable.  Given that Java is the only language with 
a notable git-related code base, for which the default fails, Java is the 
prime (if not the only) reason I wanted this whole patch series in the 
first place.

> How about doing something like this?

I do not see how a table in diff.c could be easier to maintain than a 
small part in a small function in diff.c.  It would make sense, though, to 
move the table to xdiff-interface.[ch].

Ciao,
Dscho
