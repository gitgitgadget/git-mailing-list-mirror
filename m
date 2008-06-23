From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 13:28:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806231326580.6440@racer>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <7vr6aoirqh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 14:31:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAlD6-0005i2-Kp
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 14:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbYFWMa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 08:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753078AbYFWMa4
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 08:30:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:49756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752819AbYFWMa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 08:30:56 -0400
Received: (qmail invoked by alias); 23 Jun 2008 12:30:54 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp065) with SMTP; 23 Jun 2008 14:30:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gvgcl9ctg/oL7GjGXRVyiUhwyYeSnYh/IciIa1p
	H7rO595yats9zz
X-X-Sender: gene099@racer
In-Reply-To: <7vr6aoirqh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85857>

Hi,

On Sun, 22 Jun 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > +static int blame_bottomtop_callback(const struct option *option, const char *arg, int unset)
> > +{
> > +	const char **bottomtop = option->value;
> > +	if (!arg)
> > +		return -1;
> > +	if (*bottomtop)
> > +		die("More than one '-L n,m' option given");
> > +	*bottomtop = arg;
> > +	return 0;
> > +}
> 
> Hmmmm.  I actually wanted to eventually allow more than one -L so that we
> can blame two functions inside a file, for example.  Would this make it
> even harder, I have to wonder...

IMHO this would not change anything in the way of making it harder; it is 
just a matter of adding the pairs to a container.  The more tricky thing 
is how to handle a bunch of intervals efficiently, without introducing 
too much ugliness.

Ciao,
Dscho
