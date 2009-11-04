From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Wed, 04 Nov 2009 16:52:14 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911041634030.10340@xanadu.home>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_fp0g9vL3ruTQi5QiBSWI6w)"
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:52:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nmD-00012k-Cx
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932987AbZKDVwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932984AbZKDVwL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:52:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38357 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932971AbZKDVwK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 16:52:10 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KSL00ME0U32CB30@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Nov 2009 16:52:15 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.0911041647080.10340@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132157>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_fp0g9vL3ruTQi5QiBSWI6w)
Content-id: <alpine.LFD.2.00.0911041647081.10340@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Wed, 4 Nov 2009, Andrzej K. Haczewski wrote:

> 2009/11/4 Nicolas Pitre <nico@fluxnic.net>:
> > On Wed, 4 Nov 2009, Andrzej K. Haczewski wrote:
> >
> >> +     NO_STATIC_PTHREADS_INIT = YesPlease
> >
> > Let's not go that route please.  If Windows can't get away without
> > runtime initializations then let's use them on all platforms.  There is
> > no gain in exploding the code path combinations here wrt testing
> > coverage.
> >
> 
> I don't like that approach either, but I was frighten of Junio being
> anal about static inits ;).

I think the alternative is much worse than loosing those static inits.

> Let's make it clear: has anyone have any objections that I add
> explicit initialization of mutexes and condition variables for POSIX
> also?

Please do it and if anyone finds a problem with it then we'll start from 
there.


Nicolas

--Boundary_(ID_fp0g9vL3ruTQi5QiBSWI6w)--
