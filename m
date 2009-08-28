From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 16:01:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908281554020.6044@xanadu.home>
References: <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
 <20090828150212.GA6013@coredump.intra.peff.net>
 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
 <20090828180158.GA6940@coredump.intra.peff.net>
 <81b0412b0908281127h2c444770g411ceaf052952899@mail.gmail.com>
 <20090828183958.GA11488@coredump.intra.peff.net>
 <81b0412b0908281142v7e1b73ddvb727abe915dace86@mail.gmail.com>
 <alpine.LFD.2.00.0908281458370.6044@xanadu.home>
 <81b0412b0908281208h20aa6e81od3d6567fdffa0dec@mail.gmail.com>
 <alpine.LFD.2.00.0908281516440.6044@xanadu.home>
 <20090828194913.GC9233@blimp.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 22:02:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh7eG-0000i2-4O
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 22:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbZH1UBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 16:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbZH1UBn
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 16:01:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18955 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbZH1UBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 16:01:42 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KP3008L7RMQZ640@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Aug 2009 16:01:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090828194913.GC9233@blimp.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127346>

On Fri, 28 Aug 2009, Alex Riesen wrote:

> Nicolas Pitre, Fri, Aug 28, 2009 21:27:53 +0200:
> > On Fri, 28 Aug 2009, Alex Riesen wrote:
> > > And shouldn't a linker complain regarding duplicated symbols, unless
> > > the other (library) symbol is defined as a weak symbol, allowing
> > > overriding it with another symbol of stronger linkage?
> > 
> > Normally a linker would search for new objects to link only when there 
> > are still symbols to resolve.  If the library is well architected (mind 
> > you I don't know if that is the case on Windows or OS X) you should find 
> > many small object files in a library, so to have only related functions 
> > together in a single object for only the needed code to be linked in the 
> > final binary. Hence the printf symbol should be in a separate object 
> > file than gettimeofday, etc.
> > 
> > Only if the library's object file containing gettimeofday also contains 
> > another symbol pulled by the linker will you see a duplicated symbol 
> > error.  But this is still a possibility.  So your proposal is probably 
> > cleaner.
> 
> Is it so for dynamic linking as well? Like in libc.so?

Yes.  The linker still links against stubs in that case.


Nicolas
