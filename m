From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Dec 2008, #03; Sun, 21)
Date: Tue, 23 Dec 2008 17:52:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812231746250.30769@pacific.mpi-cbg.de>
References: <7vr641pvid.fsf@gitster.siamese.dyndns.org> <20081223120534.GA21633@coredump.intra.peff.net> <alpine.DEB.1.00.0812231725270.30769@pacific.mpi-cbg.de> <20081223163811.GA25658@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 23 17:48:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFAR4-0007jo-QZ
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 17:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbYLWQr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 11:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYLWQr2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 11:47:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:36721 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751163AbYLWQr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 11:47:27 -0500
Received: (qmail invoked by alias); 23 Dec 2008 16:47:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 23 Dec 2008 17:47:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/FRc7YBa/VWoYrkZvqjNBpntph7SxGL5lZoFSL1
	atDnL9ieFXbgYK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081223163811.GA25658@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103833>

Hi,

On Tue, 23 Dec 2008, Jeff King wrote:

> On Tue, Dec 23, 2008 at 05:26:01PM +0100, Johannes Schindelin wrote:
> 
> > > I haven't had much time to really look at this closely, and I probably 
> > > won't for another week or so due to the holidays. But from my cursory 
> > > examination, I think I want to propose something that is a bit 
> > > different.
> > 
> > Could you be a bit more, like, specific, please?
> 
> The way that GIT_NOTES_REF and core.notesref work aren't what I had in 
> mind. I imagined something more amenable to having lots of different 
> metadata notes.  Refer to the other messages I have written on "naming".

Unfortunately, there were way too many messages between you and Govind, 
with not enough new stuff that could interest me, so I had to stop reading 
them to avoid depleting my Git time budget each and every single day.

However, note that without something like core.notesref you will never be 
able to have private and public notes.

And I very much want to have private notes _and_ public notes on the very 
same commits of the very same branches.

> I don't want to hold up progress, so if people want those patches in 
> "next", then go for it. What I really meant by my email was that I think 
> my suggested changes might be simpler to see as a re-roll rather than 
> patches on top, but since I can't work on them for a while, I didn't 
> want Junio to take silence as "OK, nobody has complained, so it's time 
> for this to graduate to next." But again, if people are ready to start 
> playing with this and building on top of it, then I don't want to stand 
> in the way.

I just wanted to fiddle a little bit with profiling, as I really do not 
understand why the new notes perform that badly against the old notes, 
even allowing for reading a complete, possibly huge tree into a hashmap.

And while I am almost sure that there is a stupid bug lurking that will 
kick the performance again, I think the basic design is sound, and it 
should be easy to modify no matter which way you want to change the 
behavior with regards to trees/blobs or refs.

Of course, I'd like Miklos' read-tree bug solved before any more work is 
done on notes, since we are in -rc4 after all, and that is a potentially 
pretty serious bug.

Ciao,
Dscho
