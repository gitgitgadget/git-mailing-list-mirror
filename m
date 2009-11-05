From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Thu, 05 Nov 2009 17:15:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911051708240.10340@xanadu.home>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
 <40aa078e0911041341s1adbbf31t6961207ba9c7905b@mail.gmail.com>
 <4AF20534.2030004@gmail.com> <alpine.LFD.2.00.0911042111270.10340@xanadu.home>
 <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com>
 <alpine.LFD.2.00.0911051422590.10340@xanadu.home>
 <16cee31f0911051238v71ec4b57s415efb7bb48999d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_0eqwmOJtzi/q6qG5nqyFwg)"
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 23:16:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Ad4-0002o9-2M
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 23:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758927AbZKEWQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 17:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758816AbZKEWQI
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 17:16:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26807 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758613AbZKEWQH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 17:16:07 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KSN00F92PTD7FO0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Nov 2009 17:15:13 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <16cee31f0911051238v71ec4b57s415efb7bb48999d1@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132249>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_0eqwmOJtzi/q6qG5nqyFwg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Thu, 5 Nov 2009, Andrzej K. Haczewski wrote:

> 2009/11/5 Nicolas Pitre <nico@fluxnic.net>:
> > Why not?  At least gcc is quite happy with such a construct.  It
> > probably makes a copy of the stack before passing it though.

"a copy of the struct" I meant here.

> Err... my mind is rotted with all that ugly java, c#, python and ruby,
> even c++. I should start taking some medications I suppose... what was
> I thinking is that C can't copy-construct a struct. Damn, too much sun
> (of java fame)...
> 
> That way I rediscovered simple struct construct...man I missed C so much :)

Welcome back !  ;-)

> Anyway, the solution with passing pthread_t as pointer saves some
> stack, so it's probably not that bad.

Yep, just what I said.  Normally if you pass a structure to a function, 
it will be copied beforehand so modifications by the callee won't be 
seen by the caller.  But in this case we don't care, hence passing the 
original structure address is more efficient.


Nicolas

--Boundary_(ID_0eqwmOJtzi/q6qG5nqyFwg)--
