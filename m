From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 21:58:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711282156520.27959@racer.site>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
 <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711281307420.27959@racer.site> <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>
 <Pine.LNX.4.64.0711282039430.27959@racer.site>
 <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com>
 <7vhcj63uhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUwF-0003go-Ny
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 22:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322AbXK1V7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 16:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbXK1V7E
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 16:59:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:43428 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755166AbXK1V7C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 16:59:02 -0500
Received: (qmail invoked by alias); 28 Nov 2007 21:59:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 28 Nov 2007 22:59:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Thcgq0z8T6XHBsBsefEQOP6fnK4zKRZnlOo2ihb
	n642dggsd3NpOI
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcj63uhw.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66433>

Hi,

On Wed, 28 Nov 2007, Junio C Hamano wrote:

> "Lars Hjemli" <hjemli@gmail.com> writes:
> 
> > On 11/28/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> On Wed, 28 Nov 2007, Steven Grimm wrote:
> >> > I wonder if this shouldn't be branch.<name>.pulltype or something like
> >> > that, so we can represent more than just "rebase or not." Values could
> >> > be "rebase", "merge" (the default) and maybe even "manual" to specify
> >> > that git-pull should neither merge nor rebase a particular branch even
> >> > if it matches a wildcard refspec.
> >>
> >> I am not convinced that this is a good thing... We already have
> >> branch.<name>.mergeOptions for proper merges, and I want to make clear
> >> that this is about rebase, and not about merge.
> >
> > Maybe branch.<name>.pullOptions ?
> 
> Maybe not make this part of git-pull at all?  merge and rebase have
> totally different impact on the resulting history, so perhaps a separate
> command that is a shorthand for "git fetch && git rebase" may help
> unconfuse the users.

Not so sure about that.  We already have too many commands, according to 
some outspoken people, and this would add to it.

Besides, the operation "pull" is about getting remote changes incorporated 
in your current branch.  IMHO "pull = fetch + merge" is only a technical 
detail, and we should not be bound by it too much.

Ciao,
Dscho
