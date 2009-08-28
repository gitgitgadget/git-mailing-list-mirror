From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 21:49:13 +0200
Message-ID: <20090828194913.GC9233@blimp.localdomain>
References: <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com> <20090828150212.GA6013@coredump.intra.peff.net> <alpine.LFD.2.00.0908281307510.6044@xanadu.home> <20090828180158.GA6940@coredump.intra.peff.net> <81b0412b0908281127h2c444770g411ceaf052952899@mail.gmail.com> <20090828183958.GA11488@coredump.intra.peff.net> <81b0412b0908281142v7e1b73ddvb727abe915dace86@mail.gmail.com> <alpine.LFD.2.00.0908281458370.6044@xanadu.home> <81b0412b0908281208h20aa6e81od3d6567fdffa0dec@mail.gmail.com> <alpine.LFD.2.00.0908281516440.6044@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:49:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh7SB-0005Wl-ME
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbZH1Ttb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 15:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbZH1Tta
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:49:30 -0400
Received: from mout5.freenet.de ([195.4.92.95]:55849 "EHLO mout5.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894AbZH1Tt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:49:29 -0400
Received: from [195.4.92.12] (helo=2.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1Mh7Rl-0006wt-H1; Fri, 28 Aug 2009 21:49:17 +0200
Received: from x54ff.x.pppool.de ([89.59.84.255]:37348 helo=tigra.home)
	by 2.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #94)
	id 1Mh7Rl-0005Hj-8S; Fri, 28 Aug 2009 21:49:17 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 10C33277D8;
	Fri, 28 Aug 2009 21:49:14 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id CA97636D28; Fri, 28 Aug 2009 21:49:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908281516440.6044@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127344>

Nicolas Pitre, Fri, Aug 28, 2009 21:27:53 +0200:
> On Fri, 28 Aug 2009, Alex Riesen wrote:
> > And shouldn't a linker complain regarding duplicated symbols, unless
> > the other (library) symbol is defined as a weak symbol, allowing
> > overriding it with another symbol of stronger linkage?
> 
> Normally a linker would search for new objects to link only when there 
> are still symbols to resolve.  If the library is well architected (mind 
> you I don't know if that is the case on Windows or OS X) you should find 
> many small object files in a library, so to have only related functions 
> together in a single object for only the needed code to be linked in the 
> final binary. Hence the printf symbol should be in a separate object 
> file than gettimeofday, etc.
> 
> Only if the library's object file containing gettimeofday also contains 
> another symbol pulled by the linker will you see a duplicated symbol 
> error.  But this is still a possibility.  So your proposal is probably 
> cleaner.

Is it so for dynamic linking as well? Like in libc.so?
