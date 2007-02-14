From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-pull and tag objects
Date: Wed, 14 Feb 2007 12:18:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702141213150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1170933407.15431.38.camel@okra.transitives.com>
 <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
 <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org>
 <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
 <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net> <20070212162745.GB2741@thunk.org>
 <7vr6su1szp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702132230490.3604@woody.linux-foundation.org>
 <7vfy99td98.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 12:18:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHI9g-0000bD-Q6
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 12:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbXBNLSa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 06:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbXBNLSa
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 06:18:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:58318 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932205AbXBNLS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 06:18:29 -0500
Received: (qmail invoked by alias); 14 Feb 2007 11:18:27 -0000
X-Provags-ID: V01U2FsdGVkX1/hoj5U/g3hnqCrrsdOYYkh0LPROjplAfs/sRbOZd
	x1IQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfy99td98.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39634>

Hi,

On Tue, 13 Feb 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > And you could certainly do the "passed testing" thing with commits in 
> > a separate branch instead: you'd create the "testing" branch, which is 
> > always a set of commits that have as their primary parent the commit 
> > that got tested, and as the second parent the previous commit in the 
> > "testing" series).
> 
> I personally feel that that kind of commit is misusing the parent field 
> (for one thing, it would not play well with merges at all, although 
> people who abuse commits to record non-ancestry structure may not even 
> be interested in merging such things so it may not be a problem in 
> practice).

I don't think it is misusing the parent field, but I would make the 
primary parent the ancestor in terms of testing. In a very real sense, 
this maps the history -- not of development, but of testing. It also makes 
sense to bisect on this line of history.

The chance of a mismerge is somewhat real, though. At first I thought that 
you'd need a special script anyway, until I realized that it's just a 
matter of "git merge -s theirs <from-devel>".

Ciao,
Dscho
