From: Nicolas Pitre <nico@cam.org>
Subject: Re: auto gc again
Date: Thu, 20 Mar 2008 00:40:20 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803200030020.2947@xanadu.home>
References: <20080318180118.GC17940@kernel.dk>
 <7vd4pq2ymo.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191444490.3020@woody.linux-foundation.org>
 <7vod9a1h8e.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191910170.2947@xanadu.home>
 <7vd4pq1el3.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803192228260.2947@xanadu.home>
 <7vfxumyr2r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <jens.axboe@oracle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 05:41:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcCaZ-00072a-10
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 05:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbYCTEkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 00:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbYCTEkg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 00:40:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29469 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbYCTEkV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 00:40:21 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JY000JC4IB8SPF0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Mar 2008 00:40:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vfxumyr2r.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77624>

On Wed, 19 Mar 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > So you have 17.1 seconds for a single pack vs 18.4 seconds for 66 packs.
> >
> > Compare that to 24.9s without that patch.
> 
> Very interesting --- why should it affect a single pack case at all?

It is not:

Single pack = 17.1s
66 packs with commit f7c22cc6 = 18.4s
66 packs without commit f7c22cc6 = 24.9s

The point is that having many packs doesn't impose a significant 
overhead anymore when comparing to the single pack case.

> Thanks, let's raise it to 50 then.

Having only to set gc.auto=0 to disable it entirely is also a good 
thing.

> But I am still puzzled...

Please tell me why if this is still the case.


Nicolas
