From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Sun, 4 May 2008 10:38:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805041032070.30431@racer>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org>
 <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> <7vk5ig745b.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness> <7viqy05mhp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness> <7v63u05khw.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness> <7v1w4o3zle.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness>
 <7vr6cn1yzk.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804301253520.2136@eeepc-johanness> <7vy76tyhfd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805031340550.30431@racer> <7vtzhfuxfd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 11:40:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsah3-0007M7-Lo
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 11:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbYEDJix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 05:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbYEDJix
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 05:38:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:43366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752189AbYEDJiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 05:38:52 -0400
Received: (qmail invoked by alias); 04 May 2008 09:38:51 -0000
Received: from dslb-088-067-220-031.pools.arcor-ip.net (EHLO dslb-088-067-220-031.pools.arcor-ip.net) [88.67.220.31]
  by mail.gmx.net (mp011) with SMTP; 04 May 2008 11:38:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xvYpxRi7xWcA2t1kK5AHX7ajZQEwWksmHPDa/wG
	gJ6g34prKT0vaX
X-X-Sender: gene099@racer
In-Reply-To: <7vtzhfuxfd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81156>

Hi,

On Sat, 3 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> And I try to stress that while we are still in the drawing board 
> >> phase, because it would be painful to change once we start with a 
> >> language without enough expressiveness.
> >
> > Unfortunately, we are no longer in the drawing board phase, because 
> > the offending code is already in 'next'.
> 
> What does that mean?  "Now we are committed to it, so I will stop 
> complaining and work within the overall design in a more constructive 
> way"?

Fine.

I think that the "mark" mechanism is a fine thing for scripts that import 
into Git.  There, the limitation to integers in a certain range does not 
hurt.

The "mark" mechanism could even be used to implement a user-friendly 
rebase -i -p, but I think that _exposing_ it is a mistake.

Sure, I could imagine that _editing_ a list of commits, you want to mark a 
commit (why not "tag", which would be much more consistent with the rest 
of Git?), but name it something human-readable, such as

	pick 1234567 Clean up rebase -i -p
	tag cleanup
	...
	merge 2345678 cleanup master

Yes, you read that correctly, I think that allowing plain ref names is 
very valuable.  AFAICT my original implementation allows that (dunno about 
the current code).

I actually grow fonder and fonder of the ' idea (rewritten commits can be 
referenced by their short commit name with a single apostroph appended, 
and if that commit was not rewritten at all, it falls back to the original 
commit).

That should please you, and the other guy commenting on the "magic".

In the meantime I am also convinced that it could be implemented in an 
elegant way.

Ciao,
Dscho
