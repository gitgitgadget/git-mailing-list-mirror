From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
 whitespace.
Date: Mon, 28 Apr 2008 22:30:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804282228270.19187@eeepc-johanness>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <7vej8rgq62.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281112500.2949@eeepc-johanness> <7vd4oac5qf.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804281851520.19187@eeepc-johanness> <7vprs9brlh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:31:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqawZ-0002AE-SJ
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936080AbYD1Vam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937868AbYD1Vak
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:30:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:43893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936817AbYD1Vaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:30:39 -0400
Received: (qmail invoked by alias); 28 Apr 2008 21:30:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp037) with SMTP; 28 Apr 2008 23:30:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/JzMEwJu/rz7F5g0LJtpY/L71id/2bSiszTyUaw
	Phe+Ssb0UC4L+W
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vprs9brlh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80622>

Hi,

On Mon, 28 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 28 Apr 2008, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > Maybe an example would help:
> >> >
> >> > -- snip --
> >> > pick abcdefg This is the first commit to be picked
> >> > reset cdefghij
> >> > pick zyxwvux A commit in a side-branch
> >> > merge recursive abcdefg
> >> > -- snap --
> >> 
> >> Indeed it does.  "reset cdefghij" --- does it reset to the exact cdefghij
> >> commit, or cdefghij commit after rewriting?
> >
> > In the example, it would be the original commit.  However, a "reset 
> > abcdefg" _after_ the "pick abcdefg" line would refer to the _rewritten_ 
> > commit.
> >
> > The rationale: you are most likely not wanting to reference _both_ the 
> > original _and_ the rewritten commit.
> 
> That means moving the lines around inside the todo insn list makes the
> same "reset cdefghij" mean different things.
> 
> That's insanity.

I beg you pardon?

Consider this history:

A - B - C - D
      \
        E - F

Now, depending if B was rewritten or not, would you not want the reset 
before E to mean _different_ things?

I.e. _if_ B is rewritten, E should branch off of the _rewritten_ B, but if 
B is _not_ rewritten, E should branch off of the original B?

Ciao,
Dscho
