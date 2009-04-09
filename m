From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Thu, 09 Apr 2009 15:36:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904091535150.6741@xanadu.home>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
 <20090409081443.GB17221@coredump.intra.peff.net>
 <alpine.LFD.2.00.0904091342170.6741@xanadu.home>
 <7vskkh1va5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Michael Witten <mfwitten@gmail.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 21:37:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls04G-0001s4-Km
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 21:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933648AbZDITgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 15:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762094AbZDITgI
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 15:36:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63116 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761914AbZDITgH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 15:36:07 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHU00EK3MG0W7G0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Apr 2009 15:36:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vskkh1va5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116201>

On Thu, 9 Apr 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Thu, 9 Apr 2009, Jeff King wrote:
> >
> >> On Wed, Apr 08, 2009 at 09:25:25AM -0500, Michael Witten wrote:
> >> 
> >> > Firstly, I presume that someone is electing to use this option, so it is
> >> > almost by definition not annoying for that person.
> >> 
> >> Sure, obviously only people who enable it will be affected. I was
> >> thinking of it more in terms of group economics: how many people _will_
> >> enable it, because they think the payoff outweighs the annoyance.
> >
> > My ISP doesn't allow me to send more than 20 emails at once.
> 
> Hmm, I first thought you meant 20 emails in a single smtp session, but it
> appears that we create a new instance of Net::SMTP for each piece of email
> so it really sounds like it is time based (N pieces of e-mail within M
> minutes).
> 
> Perhaps --pause=N,M to say "Pause N seconds for every M messages", where
> Michael's --delay=N is just a shorthand for --pause=N,1 is what you want?
> That is, reset the counter to 0 at the beginning, increment it after
> sending each message, and when the counter is M and if you have more to
> send, you wait for N seconds and reset the counter to 0.  Then when you
> have a series smaller than 20 you won't have to suffer from any artificial
> delay.

I suppose that would work fine too.


Nicolas
