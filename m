From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 14:01:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181357330.6044@xanadu.home>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
 <7v1vn9f4mz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 20:02:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdT0h-0005cQ-PZ
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 20:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759297AbZHRSCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 14:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754266AbZHRSCC
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 14:02:02 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47165 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbZHRSCB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 14:02:01 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOL00GHD3F96LI0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 14:01:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v1vn9f4mz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126432>

On Tue, 18 Aug 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Tue, 18 Aug 2009, Nicolas Pitre wrote:
> >
> >> Well...  Given that git already uses ntohl/htonl quite extensively in 
> >> its core already, I'd suggest making this more globally available 
> >> instead.
> >
> > What about something like this?
> 
> For git's own use, I would be much happier with this change.
> 
> But given that there are some people wanting to snarf block-sha1/*.[ch]
> out to use them standalone, I have a slight hesitation against introducing
> the dependency to git-compat-util.h, making it unclear to them that all
> this file wants from outside are ntohl, htonl and memcpy.

Should we really care to keep our code suboptimal just to make it 
readily reusable by other projects?  That seems a bit backward to me.

We might simply add a comment telling people what git-compat-util.h is 
actually for, namely memcpy(), ntohl() and htonl().  That should be 
trivial for them to use the appropriate substitute.


Nicolas
